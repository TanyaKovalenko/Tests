#!/bin/bash
cleanup() {
  rm -f #"$TEMP_FILE_WITH_OUTPUT_STRING" "$TEMP_FILE_INPUT"
}
trap cleanup EXIT

cd ~/Documents/Labs/seminar-materials/c++/task-implementation/src
RANGE=20
MAX_NUM_OF_EL_IN_ARRAY=$RANDOM
let "MAX_NUM_OF_EL_IN_ARRAY %= $RANGE"
index_of_string_in_array=0
while [ $index_of_string_in_array -lt $MAX_NUM_OF_EL_IN_ARRAY ]
do
  input_array[$index_of_string_in_array]=$RANDOM
  index_of_string_in_array=$[$index_of_string_in_array+1]
done

TEMP_FILE_INPUT=~/Documents/Labs/seminar-materials/c++/task-implementation/src/input_file
touch $TEMP_FILE_INPUT
echo "${input_array[@]}" > $TEMP_FILE_INPUT
TEMP_FILE_WITH_OUTPUT_STRING=`mktemp outXXXXXXXXX`

declare -a output_array_of_strings
index_of_string_in_array=0
echo `make run-1 ARGS="2 ~/Documents/Labs/seminar-materials/c++/task-implementation/src/input_file"` > $TEMP_FILE_WITH_OUTPUT_STRING 

DIFF=$(diff $TEMP_FILE_WITH_OUTPUT_STRING $TEMP_FILE_INPUT) 
	if [ $? -ne 0 ]
	then
		echo "Error"
		exit 1
	fi