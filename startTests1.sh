#!/bin/bash
cp report.html results1.html
./run_tests.sh > tests.out 2>&1
sed -e 's/&/&amp/g' tests.out > tests1.out
cat tests1.out > tests.out
sed -e 's/"/&quot/g' tests.out > tests1.out
cat tests1.out > tests.out
sed -e "s/'/&apos/g" tests.out > tests1.out
cat tests1.out > tests.out
sed -e 's/</&lt/g' tests.out > tests1.out
cat tests1.out > tests.out
sed -e 's/>/&gt/g' tests.out > tests1.out
cat tests1.out > tests.out
echo "<br> <b> VALGRIND REPORT: </b>" >> results1.html
awk 'BEGIN{print "<table BORDER=0 CELLSPACING=2 CELLPADDING=2> <caption> <b> <br> Tests results: <br> </b> </caption>"} {print "<tr>";print "<td>" $0"</td>";print "</tr>"} END{print "</table>"}' < tests.out >> results1.html
for arg in _1_1 _1_2 _1_3_1 _1_3_2 _1_3_3 _1_3_4 _1_4
do
	htmlFile=memcheckRes$arg.html
    	xmlFile=memcheckRes$arg.xml
	cat memcheckRes$arg.xml
	xsltproc -o $htmlFile style.xsl $xmlFile
	echo "<br> <b> LAB$arg: </b> <br>" >> results1.html
    	cat $htmlFile >> results1.html
done
