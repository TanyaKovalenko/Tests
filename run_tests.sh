git config user.name "Builder"
git config user.email "builder@localhost"
git merge --no-commit origin1/buggy-implementation
bold=$(tput bold)
normal=$(tput sgr0)
echo "
${bold}LAB 1.1:${normal}
"
"$WORKSPACE"/test_lab_1_1.sh
echo "
${bold}LAB 1.2:${normal}
"
"$WORKSPACE"/test_lab_1_2.sh
echo "
${bold}LAB 1.3.1:${normal}
"
"$WORKSPACE"/test_lab_1_3_1.sh
echo "
${bold}LAB 1.3.2:${normal}
"
"$WORKSPACE"/test_lab_1_3_2.sh
echo "
${bold}LAB 1.3.3:${normal}
"
"$WORKSPACE"/test_lab_1_3_3.sh
echo "
${bold}LAB 1.3.4:${normal}
"
"$WORKSPACE"/test_lab_1_3_4.sh
echo "
${bold}LAB 1.4:${normal}
"
"$WORKSPACE"/test_lab_1_4.sh