touch $WORKSPACE/results.html
cat $WORKSPACE/report.html > $WORKSPACE/results.html 
valgrind --tool=massif $WORKSPACE/run_tests.sh | awk 'BEGIN{print "<table BORDER=0 CELLSPACING=2 CELLPADDING=2> <caption> <b> <br> Massif tool: <br> </b> </caption>"} {print "<tr>";print "<td>" $0"</td>";print "</tr>"} END{print "</table>"}' >> $WORKSPACE/results.html 
echo "<br> <b> VALGRIND REPORT: </b>" >> $WORKSPACE/results.html 
valgrind --tool=cachegrind $WORKSPACE/run_tests.sh 2>&1 >/dev/null | awk 'BEGIN{print "<table BORDER=0 CELLSPACING=2 CELLPADDING=2> <caption> <b> <br> Test results: <br> </b> </caption>"} {print "<tr>";print "<td>" $0"</td>";print "</tr>"} END{print "</table>"}' >> $WORKSPACE/results.html