#!/bin/bash
cleanup() {
  rm -f "$TEMP_FILE_WITH_OUTPUT_STRINGS" "$TEMP_FILE_WITH_SORTED_ARRAY" "$TEMP_FILE_WITH_OUTPUT_ARRAY"
}
trap cleanup EXIT
echo "Run test for lab 1.1 ... "
RANGE=20
MAX_NUM_OF_EL_IN_ARRAY=$RANDOM
let "MAX_NUM_OF_EL_IN_ARRAY %= $RANGE"
index_of_string_in_array=0
while [ $index_of_string_in_array -lt $MAX_NUM_OF_EL_IN_ARRAY ]
do
  input_array[$index_of_string_in_array]=$RANDOM
  index_of_string_in_array=$[$index_of_string_in_array+1]
done
index_of_string_in_array=0
declare -a output_array_of_strings
TEMP_FILE_WITH_OUTPUT_STRINGS=`mktemp outXXXXXXXXX`
echo "${input_array[@]}" | make run-martynov.alexey/1 VALGRIND="--leak-check=full --track-origins=yes --xml=yes --xml-file='memcheckRes_1_1.xml'" ARGS="1 ascending" > $TEMP_FILE_WITH_OUTPUT_STRINGS 
while read line ; do
	output_array_of_strings[$index_of_string_in_array]=$line
	index_of_string_in_array=$[$index_of_string_in_array+1]
done < $TEMP_FILE_WITH_OUTPUT_STRINGS
num_of_output_string=0
TEMP_FILE_WITH_SORTED_ARRAY=`mktemp outXXXXXXXXX`	
TEMP_FILE_WITH_OUTPUT_ARRAY=`mktemp outXXXXXXXXX`
while [ $num_of_output_string -lt 3 ]
do	
	output_string="${output_array_of_strings[num_of_output_string]}"
	output_array=($output_string)
	declare -a sorted_input_array
	sorted_input_array=(`echo "${input_array[@]}" | tr ' ' '\n' | sort -n | tr '\n' ' '`)		
	echo "${sorted_input_array[@]}" | tr ' ' '\n' > $TEMP_FILE_WITH_SORTED_ARRAY
	echo "${output_array[@]}" | tr ' ' '\n' > $TEMP_FILE_WITH_OUTPUT_ARRAY
	diff -u $TEMP_FILE_WITH_SORTED_ARRAY $TEMP_FILE_WITH_OUTPUT_ARRAY
	if [ $? -ne 0 ]
	then
		echo "Error: Output array is not sorted."
		exit 1
	fi   	
	num_of_output_string=$[$num_of_output_string+1]
done
echo "Program works correctly."