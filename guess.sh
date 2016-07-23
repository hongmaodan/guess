#!/bin/bash

function guessread() {
	guessnu=""
	read -p "Input your guessing number: " guessnu
	return 0
}

function nucheck() {
	inu=`echo ${guessnu} | grep '[^[:digit:]]'`
	while [ "${inu}" != "" ] || [ "${guessnu}" == "" ]
	do
        	echo "Wrong input, number only!";guessread
		inu=`echo ${guessnu} | grep '[^[:digit:]]'`
	done
	while [ "${guessnu}" -gt 999 ]
	do
		echo "The number is too big! it's below 1000.";guessread
	done
	return 0
}

echo -e "It's a number guessing game.\nGive your answer and the count of guessing will be given after you succeed.\nThe num is lower than 1000.\n"

target=$((${RANDOM}*999/32767))
guessct=1

guessread;nucheck

if [ "${target}" == "${guessnu}" ];then
	echo "Bingo at the first time! You are great!!"
	exit 0
fi

until [ "${target}" -eq "${guessnu}" ]
do
	diffnu=$((${guessnu}-${target}))
	if [ ${diffnu} -gt 0 ];then
		flag=1
	elif [ ${diffnu} -lt 0 ];then
		flag=-1
	else
		flag=0
	fi

	case ${flag} in
		"1")
			echo "It's too high! Try lower number."
			;;
		"-1")
			echo "It's too low! Try higher number."
			;;
		*)
			echo "Bingo! you guessed ${guessct} times."
			exit 0
			;;
	esac	
	((guessct++));guessread;nucheck
done

((guessct++))
echo "Bingo! you guessed ${guessct} times."

