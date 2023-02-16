CPATH=".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar"

rm -rf student-submission
rm -rf testing
git clone $1 student-submission
echo 'Finished cloning'

if [[ -f "./student-submission/ListExamples.java" ]]
    then
        echo "The file ListExamples.java exists"
    else
        echo "Missing File ListExamples.java" 1>&2
        exit 1
fi

mkdir testing
cp TestListExamples.java ./testing
cp ./student-submission/ListExamples.java ./testing
cp -r ./lib ./testing
cd testing

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java
if [[ $? == 0 ]]
    then
        echo "Files compiled succesfully"
    else
        echo "ListExamples.java failed to compile" 1>&2
        exit 1
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > TestResuts.txt
if [[ $? -eq 0 ]]
    then
        echo "Files ran succesfully"
    else
        echo "Files Failed to execute" 1>&2
        exit 1
fi
