#!/bin/bash
cp report.html results.html 
echo "<br> <b> VALGRIND REPORT: </b>" >> results.html
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
cat tests.out
awk 'BEGIN{print "<table BORDER=0 CELLSPACING=2 CELLPADDING=2> <caption> <b> <br> Memcheck tool: <br> </b> </caption>"} {print "<tr>";print "<td>" $0"</td>";print "</tr>"} END{print "</table>"}' < tests.out >> results.html
for arg in _1_1 _1_2 _1_3_1 _1_3_2 _1_3_3 _1_3_4 _1_4
do
	htmlFile=memcheckRes$arg.html
    	xmlFile=memcheckRes$arg.xml
	xsltproc -o $htmlFile style.xsl $xmlFile
    	cat $htmlFile >> results.html
done