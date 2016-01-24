git config user.name "Builder"
git config user.email "builder@localhost"
git merge --no-commit origin1/c++-2016
cd c++/task-implementation/src
"$WORKSPACE"/test_lab_1_1.sh
"$WORKSPACE"/test_lab_1_2.sh
"$WORKSPACE"/test_lab_1_3_1.sh
"$WORKSPACE"/test_lab_1_3_2.sh
"$WORKSPACE"/test_lab_1_3_3.sh
"$WORKSPACE"/test_lab_1_3_4.sh
"$WORKSPACE"/test_lab_1_4.sh
cd out/1
valgrind --tool=memcheck --xml=yes --xml-file=res.xml" --log-file="res.log" ./lab 4 ascending 3