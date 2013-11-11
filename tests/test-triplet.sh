#!/bin/sh
split_host() {
S="$"
while : ; do
ENVWORDS="${ENVWORDS} $1_CPU $1_OS"
STR=`eval "echo ${S}$1"`
SPLIT_CPU="`echo "$STR" | cut -d - -f 1`"
SPLIT_OS="`echo "$STR" | awk -F - '{
	if($1="unknown"){
		if (NF<3) {
			print $2;
		} else {
			print $3;
		}
	} else {
		print $(NF-1);
	}
}'`"
eval "$1_CPU=\"$SPLIT_CPU\""
eval "$1_OS=\"$SPLIT_OS\""
shift
[ -z "$1" ] && break
done
}


test () {
	HOST="$1"
	split_host HOST

	echo ${HOST}
#	echo HOST_OS=$HOST_OS
#	echo HOST_CPU=$HOST_CPU
	if [ "${HOST_OS}" != "$2" ]; then
		echo "  OS FAIL   - $HOST_OS vs $2"
	fi
	if [ "${HOST_CPU}" != "$3" ]; then
		echo "  CPU FAIL   - $HOST_CPU vs $3"
	fi
}

UNAME=`uname | tr '[A-Z]' '[a-z]'`
test i386-unknown-openbsd openbsd i386
test amd64-unknown-openbsd openbsd amd64
test x86_64-unknown-linux-gnu linux x86_64
test arm-foo-linux-gnueabihf linux arm
#test openbsd-unknown-i386 openbsd i386
test x86_64-unknown-darwin darwin x86_64
test i686-pc-linux-gnu linux i686
test m68k-coff $UNAME m68k
test alpha-netbsd netbsd alpha
test i686-pc-mingw32 mingw32 i686
test m68k-apple-macos macos m68k
test x86_64-w64-mingw32 mingw32 x86_64
