#!/bin/sh

print_report() {
	echo
	if [ "${ERROR}" = 0 ]; then
		echo "OK: All tests has passed fine"
	else
		echo "ERROR: $ERROR/$COUNT tests has failed."
	fi

	exit ${ERROR}
}

do_remove() {
	rm -f `ls | egrep -v "test.sh|CVS"`
}

control_c() { 
  printf "\n\n^C control-c : script execution interrupted.\n" 
  do_remove 
  print_report
  exit 1 
} 

trap control_c 2 


PATH=${PWD}/../src:${PATH}
chmod +x ../src/acr ../src/acr-sh

ERROR=0
COUNT=0

for A in ../examples/*.acr ; do
	echo "[*] generating ${A} "
	cp ${A} configure.acr
	acr -p >/dev/null
	if [ "$?" = "0" ]; then
		echo "[>] executing ${A}"
		./configure 2>/dev/null > /dev/null
		echo ""
	else
		echo "[FAILED]"
		acr >/dev/null
		ERROR=$(($ERROR+1))
	fi
	COUNT=$(($CONUT+1))
	rm configure.acr
done

do_remove

print_report
