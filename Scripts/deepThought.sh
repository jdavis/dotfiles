#!/bin/bash

if [ $# -lt 1 ]; then
	echo Usage: deepThought.sh [file name]
	exit
fi

#for ((i=2; i<$#+1; i++))
#do
	#flags="${s} ${!i}"
#done

flags=`perl -ne '@x=split(/Flags/, $_); END { print $x[1] }' $1`

clear
echo

f=${1##*/} # Name and Extension
n=${f%%.*} # Name of File
p=${1%/*} # Path of File

if [[ -f $1 ]] ; then
	case $1 in
		*.s)
			printf "Assembling $1...\n"
			as $1 -o $p/Assembled/$n.o && printf "Assembled to $p/Assembled/$n.o\n" && ld $p/Assembled/$n.o -o $p/Loaded/$n && printf "Loaded to $p/Loaded/$n\nRunning $p/Loaded/$n...\n\n" && $p/Loaded/$n;
			;;
		*.m|*.c)
			printf "Compiling $1...\n\n";
			gcc $flags $1 -o $p/$n && printf "Build Suceeded. Running $p/$n...\n\n" && $p/$n;
			;;
		*.h)
			printf "Cocoa Header here!\n\n";;
		*.scm)
			printf "Running Scheme Script...\n\n";
			scheme $flags $1;
			;;
		*.sh)
			printf "Running Script $1...\n\n";
			sh $1;
			;;
		*.py)
			printf "Running Python Script with$flags...\n\n";
			python "${1}" $flags;
			;;
		*.pl)
			printf "Running Perl Script...\n\n";
			perl $1 $flags;
			;;
		*.js)
			printf "Validating JavaScript...\n\n";
			jsl -nologo -nofilelisting -nocontext -nosummary -process $1
			;;
		*)
			echo $1 cannot be interpreted ;;
	esac
else
	echo $1 does not exist.
fi
