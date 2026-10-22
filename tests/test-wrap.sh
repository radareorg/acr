#!/bin/sh
set -eu

ACR_ROOT=$(CDPATH= cd "$(dirname "$0")/.." && pwd)
ACR_WRAP=${ACR_WRAP:-${ACR_ROOT}/src/acr-wrap}
MAKE=${MAKE:-make}
TEST_DIR=$(mktemp -d "${TMPDIR:-/tmp}/acr-wrap-test.XXXXXX")
trap 'rm -rf "$TEST_DIR"' EXIT HUP INT TERM

git init -q "$TEST_DIR/source"
cd "$TEST_DIR/source"
git config user.name acr-wrap-test
git config user.email acr-wrap-test@example.invalid
echo old > content
git add content
git commit -qm old
OLD_REVISION=$(git rev-parse HEAD)
git tag v1
git tag -am annotated v1-annotated
echo new > content
git commit -qam new
NEW_REVISION=$(git rev-parse HEAD)
git branch -M main
git clone -q --bare . "$TEST_DIR/remote.git"
mkdir "$TEST_DIR/build"
cd "$TEST_DIR/build"

generate() {
	cat > project.wrap <<EOF
[wrap-git]
url = file://${TEST_DIR}/remote.git
revision = $1
directory = project
depth = 1
EOF
	sh "$ACR_WRAP" project.wrap > Makefile
}

check_revision() {
	"$MAKE" > "$TEST_DIR/make.log" 2>&1 || {
		cat "$TEST_DIR/make.log"
		exit 1
	}
	test "$(git -C project rev-parse HEAD)" = "$1"
}

check_reuse() {
	touch project/reuse-check
	mv "$TEST_DIR/remote.git" "$TEST_DIR/remote.offline"
	check_revision "$1"
	test -f project/reuse-check
	mv "$TEST_DIR/remote.offline" "$TEST_DIR/remote.git"
}

for revision in v1 v1-annotated refs/tags/v1; do
	generate "$revision"
	check_revision "$OLD_REVISION"
	check_reuse "$OLD_REVISION"
done

generate v1
git -C project update-ref -d refs/acr-wrap/v1
git -C project tag -f v1 "$OLD_REVISION"
check_reuse "$OLD_REVISION"

generate "$NEW_REVISION"
check_revision "$NEW_REVISION"
test ! -f project/reuse-check
check_reuse "$NEW_REVISION"
git -C project update-ref -d "refs/acr-wrap/$NEW_REVISION"
check_reuse "$NEW_REVISION"

generate main
check_revision "$NEW_REVISION"
check_reuse "$NEW_REVISION"
"$MAKE" project_clean > "$TEST_DIR/make.log" 2>&1
check_revision "$NEW_REVISION"

generate missing-revision
if "$MAKE" > "$TEST_DIR/make.log" 2>&1; then
	echo "Fetching a missing revision unexpectedly succeeded"
	exit 1
fi

echo "acr-wrap: tags, hashes, branches, updates, reuse and fetch failures passed"
