(git config user.name "Builder") > results
(git config user.email "builder@localhost") > results
(git merge --no-commit origin1/c++-2016) > results
cd c++/task-implementation/src
"$WORKSPACE"/test_lab_1_1.sh
"$WORKSPACE"/test_lab_1_2.sh
"$WORKSPACE"/test_lab_1_3_1.sh
"$WORKSPACE"/test_lab_1_3_2.sh
"$WORKSPACE"/test_lab_1_3_3.sh
"$WORKSPACE"/test_lab_1_3_4.sh
"$WORKSPACE"/test_lab_1_4.sh