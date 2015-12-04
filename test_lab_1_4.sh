#!/bin/bash
cleanup() {
  rm -f "$TEMP_FILE_WITH_OUTPUT_STRINGS" "$TEMP_FILE_WITH_SORTED_ARRAY" "$TEMP_FILE_WITH_OUTPUT_ARRAY"
}
trap cleanup EXIT
echo "Run test for lab 1.4 ... "
MAX_NUM_OF_EL_IN_ARRAY=5
index_of_string_in_array=0
declare -a output_array_of_strings
TEMP_FILE_WITH_OUTPUT_STRINGS=`mktemp outXXXXXXXXX`
echo "${input_array[@]}" | make run-1 ARGS="4 ascending 5" > $TEMP_FILE_WITH_OUTPUT_STRINGS 
while read line ; do
	output_array_of_strings[$index_of_string_in_array]=$line
	index_of_string_in_array=$[$index_of_string_in_array+1]
done < $TEMP_FILE_WITH_OUTPUT_STRINGS
num_of_output_string=0
TEMP_FILE_WITH_SORTED_ARRAY=`mktemp outXXXXXXXXX`	
TEMP_FILE_WITH_OUTPUT_ARRAY=`mktemp outXXXXXXXXX`	
input_string="${output_array_of_strings[0]}"
input_array=($input_string)
output_string="${output_array_of_strings[1]}"
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
echo "Program works correctly."
