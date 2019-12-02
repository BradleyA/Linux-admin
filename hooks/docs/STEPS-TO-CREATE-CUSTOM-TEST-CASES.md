## Steps to create custom test cases for a file
   
**To Create Custom Test Cases**

Create a test case in directory, TEST/<FILE_TO_BE_TESTED>/, in the same direcory of the <FILE_TO_BE_TESTED>.  There are two locations to place your custom test case.  For test cases designed only for one file, use TEST/<FILE_TO_BE_TESTED>/ directory.  For test cases designed to be shared for more than one files use hooks/EXAMPLES/ directory and add a link (ln) to it in TEST/<FILE_TO_BE_TESTED>/SA-setup.sh.  Currently SA-* and FVT-* test cases are the only test cases supported by post-commit.

When creating a custom test case name it 'SA-<test-case-name-no-dot-001>' for Static Analysis (SA) or 'FVT-<test-case-name-no-dot-001>' for Funciotnal Verification Test.  For example a Functional Verification Test that tests if the option '--help' works is named FVT-option-help-001).

    
    xxxxxx

<img id="Steps git-TEST-commit-automation-5-1.gif" src="../images/git-TEST-commit-automation-5-1.gif" >
Create Custom Test Cases

## 

**That is it!**
