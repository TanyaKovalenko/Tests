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
	indexOfLab=0
        for t in `seq 1 8`
        do
		RES=$(grep -c /$t/ path_file)     
		if [ $RES -ne "0" ]
            	then
                	input_array[$indexOfLab]=$t
        	fi

	done
	ls
	for l in "${input_array[@]}"
                do
			path_in_quotes=$(cat path_file)
			path=$(echo $path_in_quotes | tr -d \")
			lab_file=$WORKSPACE/$path
			echo $lab_file
                        cppcheck $lab_file --xml 2> cppcheck-result$l.xml
                        ./startTests$l.sh
                        htmlFile=cppcheck-result$l.html
                        xmlFile=cppcheck-result$l.xml
                        cat cppcheck-result$l.xml
			#xsltproc -o $htmlFile style.xsl $xmlFile
                        #echo "<br> <b> LAB$l: </b> <br>" >> results1.html
                        #cat $htmlFile >> results1.html
                        curl -H "PRIVATE-TOKEN: SfkWoPZmXuzEAEa-XW-4" -F body="<results$l.html" -X POST https://gitlab.com/api/v3/projects/939427/merge_requests/$ID/notes
	done
    done
done
