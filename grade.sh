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

echo ""
echo "Searching for ListExamples.java..."

if [[ -f 'ListExamples.java' ]]
then
    echo 'File found!'
else
    echo 'File not found!'
    exit
fi

echo ""
echo "Attempting to compile your class..."

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

echo "Compile successful."
echo ""

echo "Searching for methods..."

FILTER_METHOD=`grep -c "static List<String> filter(List<String> list, StringChecker sc)" ListExamples.java`
MERGE_METHOD=`grep -c "static List<String> merge(List<String> list1, List<String> list2)" ListExamples.java`

if [[ $FILTER_METHOD == 0 ]]
then
    echo "Could not find your filter method! Does it exist? Are all parameters present and in the correct order?"
    echo "Expected: static List<String> filter(List<String> list, StringChecker sc)"
    echo "Actual: " `grep "filter" ListExamples.java`
    exit 1
elif [[ $MERGE_METHOD == 0 ]]
then
    echo "Could not find your merge method! Does it exist? Are all parameters present and in the correct order?"
    echo "Expected: static List<String> merge(List<String> list1, List<String> list2)"
    echo "Actual: " `grep "merge" ListExamples.java`
    exit 1
fi

echo "Methods found!"

javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java
java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples >test-output.txt

OUTPUT=`grep -c "OK" ./test-output.txt`

if [[ $OUTPUT == 0 ]]
then
    echo "Failed one or more tests."
    cat test-output.txt | grep -v -w "at" | grep -v -w "Time:" | grep -v -x ".E" | grep -v -x "JUnit version 4.13.2"
else
    echo "Passed all tests!"
fi
