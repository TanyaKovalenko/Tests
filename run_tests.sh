git config user.name "Builder"
git config user.email "builder@localhost"
git merge --no-commit origin1/buggy-implementation
tput -T linux bold
echo "
LAB 1.1:
"
tput sgr0
"$WORKSPACE"/test_lab_1_1.sh
tput -T linux bold
echo "
LAB 1.2:
"
tput sgr0
"$WORKSPACE"/test_lab_1_2.sh
tput -T linux bold
echo "
LAB 1.3.1:
"
tput sgr0
"$WORKSPACE"/test_lab_1_3_1.sh
tput -T linux bold
echo "
LAB 1.3.2:
"
tput sgr0
"$WORKSPACE"/test_lab_1_3_2.sh
tput -T linux bold
echo "
LAB 1.3.3:
"
tput sgr0
"$WORKSPACE"/test_lab_1_3_3.sh
tput -T linux bold
echo "
LAB 1.3.4:
"
tput sgr0
"$WORKSPACE"/test_lab_1_3_4.sh
tput -T linux bold
echo "
LAB 1.4:
"
tput sgr0
"$WORKSPACE"/test_lab_1_4.sh