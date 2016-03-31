#!/bin/bash
curl --header "PRIVATE-TOKEN: SfkWoPZmXuzEAEa-XW-4" 'https://gitlab.com/api/v3/projects/939427/merge_requests?state=opened' > opened_merge_requests.json
LENGTH=$(cat opened_merge_requests.json | jq '. | length')
for numOfMR in `seq 1 $LENGTH`
do
    indexOfMR=$(($numOfMR-1))
    ID=$(cat opened_merge_requests.json | jq ".[$indexOfMR].id")
	echo $ID
    curl -H "PRIVATE-TOKEN: SfkWoPZmXuzEAEa-XW-4" https://gitlab.com/api/v3/projects/939427/merge_requests/$ID/changes > changes.json
	LENGTH=$(cat changes.json | jq '.changes | length')
    for numOfChange in `seq 1 $LENGTH`
    do
    	numOfChange=$(($numOfChange-1))
        cat changes.json | jq ".changes[$numOfChange].new_path" > path_file
        for t in `seq 1 8`
        do
		RES=$(grep -c /$t/ path_file)     
		if [ $RES -ne "0" ]
            	then
            		echo "Here!!!"
                	./startTests$t.sh
            	fi
        done
    done
done
