#!/bin/bash
cleanup() {
  rm -f "$TEMP_FILE_WITH_OUTPUT_STRINGS"
}
trap cleanup EXIT
echo "Test case in which input array ends with 0 after 5"
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
let "MAX_NUM_OF_EL_IN_ARRAY = MAX_NUM_OF_EL_IN_ARRAY + 1"
input_array[$MAX_NUM_OF_EL_IN_ARRAY]=0

#cd ~/Documents/Labs/seminar-materials/c++/task-implementation/src

TEMP_FILE_WITH_OUTPUT_STRINGS=`mktemp outXXXXXXXXX`
declare -a output_array_of_strings
index_of_string_in_array=0
echo "${input_array[@]}" | make run-martynov.alexey/1 VALGRIND="--leak-check=full --track-origins=yes --xml=yes --xml-file='memcheckRes_1_3_3.xml'" ARGS="3" > $TEMP_FILE_WITH_OUTPUT_STRINGS 
while read line ; do
	output_array_of_strings[$index_of_string_in_array]=$line
	index_of_string_in_array=$[$index_of_string_in_array+1]
done < $TEMP_FILE_WITH_OUTPUT_STRINGS

output_string="${output_array_of_strings[0]}"
output_array=($output_string)

declare -a comparison_array
length_of_array=${#input_array[@]}
let "number_of_last_item = length_of_array - 1"
unset input_array[number_of_last_item]
let "number_of_last_item = number_of_last_item - 1"
last_item=${input_array[$number_of_last_item]}
index_of_array=0
for number_of_item_in_input_array in ${input_array[@]}
do	
	if [[ $last_item -eq 1 ]]
	then		
		item_in_input_array=$number_of_item_in_input_array
		let "remainder_of_the_division = item_in_input_array % 2"
		if [[ $remainder_of_the_division -eq 0 ]]
		then
			unset input_array[index_of_array]
		fi
	else 
		if [[ $last_item -eq 2 ]]
		then
			item_in_input_array=$number_of_item_in_input_array
			comparison_array[index_of_array]=$item_in_input_array
			let "item_in_input_array = item_in_input_array % 3"
			if [[ $item_in_input_array -eq 0 ]]
			then
				let "index_of_array = index_of_array + 1"
				comparison_array[index_of_array]=1
				let "index_of_array = index_of_array + 1"
				comparison_array[index_of_array]=1
				let "index_of_array = index_of_array + 1"
				comparison_array[index_of_array]=1
			fi
		fi
	fi
	let "index_of_array = index_of_array + 1"
done
if [[ $last_item -eq 2 ]]
	then
		comparison_string=${comparison_array[@]}
	else
		comparison_string=${input_array[@]}	
fi

if [[ "$comparison_string" = "$output_string" ]]
	then
		echo "Program works correctly"
	else
		echo "There is a error somewhere in your code."
		exit 1
fi

