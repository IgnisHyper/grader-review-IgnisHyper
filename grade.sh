CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf testing
git clone $1 student-submission
echo 'Finished cloning'
cd student-submission
FILES=`find .`
TRUE=1
FALSE=0
FOUND_FILE=$FALSE
for FILE in $FILES
do
    if [[ -f $FILE ]] && [[ $FILE == *ListExamples.java ]]
    then
        FOUND_FILE=$TRUE
    fi
done

if [[ $FOUND_FILE == $FALSE ]]
then
    echo 'File not found!'
    exit 1
else
    echo 'File found!'
fi

cd ..
mkdir testing
cp ./student-submission/ListExamples.java ./testing
cp ./TestListExamples.java ./testing
cp -r ./lib ./testing

cd testing
javac ListExamples.java 2>error.txt

if [[ $? != 0 ]]
then
    echo "Your file failed to compile."
    cat ./error.txt
    exit 1
fi

javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java
java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples >test-output.txt

OUTPUT=`grep -c "OK" ./test-output.txt`

if [[ $OUTPUT == 0 ]]
then
    echo "Failed one or more tests."
    cat test-output.txt
else
    echo "Passed all tests!"
fi
