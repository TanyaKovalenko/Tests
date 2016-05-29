git config user.name "Builder"
git config user.email "builder@localhost"
git merge --no-commit origin1/buggy-implementation
echo "
LAB 1_1:
"
"$WORKSPACE"/test_lab_1_1.sh
echo "
LAB 1_2:
"
"$WORKSPACE"/test_lab_1_2.sh
echo "
LAB 1_3_1:
"
"$WORKSPACE"/test_lab_1_3_1.sh
echo "
LAB 1_3_2:
"
"$WORKSPACE"/test_lab_1_3_2.sh
echo "
LAB 1_3_3:
"
"$WORKSPACE"/test_lab_1_3_3.sh
echo "
LAB 1_3_4:
"
"$WORKSPACE"/test_lab_1_3_4.sh
echo "
LAB 1_4:
"
"$WORKSPACE"/test_lab_1_4.sh