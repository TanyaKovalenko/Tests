#!/bin/bash
cleanup() {
  rm -f "$TEMP_FILE_WITH_OUTPUT_STRINGS"
}
trap cleanup EXIT
echo "Test of 1.3 lab"
RANGE=20
MAX_NUM_OF_EL_IN_ARRAY=$RANDOM
let "MAX_NUM_OF_EL_IN_ARRAY %= $RANGE"
index_of_string_in_array=0
while [ $index_of_string_in_array -lt $MAX_NUM_OF_EL_IN_ARRAY ]
do
  input_array[$index_of_string_in_array]=$RANDOM
  index_of_string_in_array=$[$index_of_string_in_array+1]
done
input_array[$MAX_NUM_OF_EL_IN_ARRAY]=5

#cd ~/Documents/Labs/seminar-materials/c++/task-implementation/src

TEMP_FILE_WITH_OUTPUT_STRINGS=`mktemp outXXXXXXXXX`
declare -a output_array_of_strings
index_of_string_in_array=0
echo "${input_array[@]}" | make run-1 ARGS="3" > $TEMP_FILE_WITH_OUTPUT_STRINGS 
if [[ $? -eq 0 ]]
then
	echo "Error"
	exit 1
else 
	echo "Program works correctly"
fi
