# git-TEST-commit-automation  [![Stable Release](https://img.shields.io/badge/Release-2.200-blue.svg)](https://github.com/BradleyA/git-TEST-commit-automation/releases/tag/2.200)    [![GitHub commits](https://img.shields.io/github/commits-since/BradleyA/git-TEST-commit-automation/2.200.svg)](https://github.com/BradleyA/git-TEST-commit-automation/commits/)

**In development** ...(8/2019 - 9/2019)   **In test** ...............(9/7/2019 - )
 
**WARNING**: These instructions are incomplete. Consider them as notes quickly drafted on a napkin rather than proper documentation!

#### Strategy:
Scripts to assist running something, and checking something, then reporting something; when you commit something.

#### About

git-TEST-commit-automation runs pre-commit and post-commit hooks when "git commit -m 'message' " is executed. Pre-commit creates a file (${REPOSITORY_DIR}/hooks/COMMIT_FILE_LIST) which includes files being commited. Post-commit searches in the same directory as the commited filename for a TEST/\<filename>/ directory. If found post-commit runs TEST/\<filename>/SA-setup.sh and/or TEST/\<filename>/FVT-setup.sh then searches for files beginning with SA- of FVT- and runs them.

TL;DR - Why did I create git-TEST-commit-automation when there are so many great open software and enterprise level testing solutions available.  I needed something that would run some basic SA and FVT tests with minimal learning curve.  A solution that would inform, not impede code development.  That would encourage 'git commit -m 'message', not exit 1 if there is any code incident.  A solution that allows basic test cases to be included with code in a Git repository.  A solution that could be setup and uninstall without effecting the code being developed.  A solution that would support adding other test solutions to this solution with minimal changes.

TL;DR - During code design, a software developer's focus is on how to solve parts of a bigger solution.  A developer may throw out a couple to dozens of lines of code.  It did not matter that those lines of code did or didn't meet every test requirement.  As a design matures it is increasingly important to have code PASS tests.  It is also important for a developer to design SA and FVT test cases for their new code.  At that time their code is ready for additional testing with open software and enterprise level solutions.

#### Objectives:
1) Quick setup with default test cases for any Git repository (in seconds)
2) Quick uninstall on any Git repository
3) Quick check of test case depth for a file (option -f) and all files for any Git repository (option -a)
4) Quick setup of default SA- test cases for a file (options --filename sample.sh --add)
5) Quick upgrade of default test cases and git-TEST-commit-automation commands (setup-git-TEST-cases.sh)
6) Quick reduction of untracked TEST case files (option -c)

#### Quick Start
	
#### [Install/evaluate git-TEST-commit-automation solution](https://github.com/BradleyA/git-TEST-commit-automation/tree/master/hooks/docs/STEPS-TO-EVALUTE.md)

#### [Uninstall git-TEST-commit-automation solution](https://github.com/BradleyA/git-TEST-commit-automation/tree/master/hooks/docs/STEPS-TO-UNINSTALL.md)

#### [View test case depth for a file](https://github.com/BradleyA/git-TEST-commit-automation/tree/master/hooks/docs/STEPS-TO-CHECK-DEPTH.md)

#### [Setup default SA- test cases for a new file](https://github.com/BradleyA/git-TEST-commit-automation/tree/master/hooks/docs/STEPS-TO-SETUP-DEFAULT-SA-TEST-CASES.md)

**Start editing from here:  These notes are cut and paste of information and make some since once I finsh design**
#### [Create custom test cases for a file](https://github.com/BradleyA/git-TEST-commit-automation/tree/master/hooks/docs/STEPS-TO-CREATE-TEST-CASES.md)
  
#### Description

**pre-commit** - Creates \<REPOSITORY>/hooks/**COMMIT_FILE_LIST** with a list of \<REPOSITORY-PATH>/\<FILE> being committed.

**post-commit** 
- Loop through committed files found in \<REPOSITORY>/hooks/**COMMIT_FILE_LIST**
- if COMMIT_FILE has a '\<REPOSITORY>/\<PATH>/TEST/\<COMMIT_FILE>/' directory run FVT-setup.sh and/or SA-setup.sh
- Loop through and run \<REPOSITORY>/\<PATH>/TEST/\<COMMIT_FILE>/SA-<TEST_CASE> and/or FVT-<TEST_CASE>
- Report output as **PASS** or **FAIL** or **ERROR**, through stdout 
      . . . some methed will notify someone of the results. (not sure which method is going to work for me and you? 
      . . . stdout, logs-scrape, tables, email, twitter, slack, call a friand, etc.)
 
**git-TEST-cases.sh** - lists and manages files in TEST case directories in current Git repository

**setup-git-TEST-cases.sh** - setup git-TEST-commit-automation in top directory of current repository

**uninstall-git-TEST-cases.sh** - uninstall git-TEST-commit-automation in current repository

#### Types of Test Cases

**Funciotnal Verification (FVT)** is defined as the process of verifying that the design meets its specification from a functional perspective. ... Functional verification establishes that the design under test (DUT) implements the functionality of the specification correctly.

**Static Analysis (SA)** is the examination of code prior to the program’s execution SA is code analysis, syntax, permission, code inspection, code review, etc.

#### ARCHITECTURE TREE

    /usr/local/bin/                           <-- <BIN_DIR>
    ├── git-TEST-cases.sh
    ├── setup-git-TEST-cases.sh
    └── uninstall-git-TEST-cases.sh>


**hooks directory**  The hooks directory was created because I wanted to modify the GitHub hooks and track changes per repository.  Include hooks/ in repostory because .git/hooks is not pushed and hooks change and these changes need to be tracked in a Git repository. (need to retest)

Place the expected results from the test case into a file with the same test case name but add '.expected' ('dot'expected).  Pipe the output from the test case into a file with the same name but add '.test-case-output'. 

====>>>  Moved from above

    git commit -m 'latest changes' <COMMIT_FILE_NAME>

After entering the above command, Git runs any Git hooks found in \<REPOSITORY-NAME>/.git/hooks/ directory.  Git hooks are scripts that Git executes before and/or after events. Two local Git hooks are included with git-TEST-commit-automation. 
  
**Note**   I found out about hooks and need to remember and add to the README why I added a hooks directory in the repository so the hooks can be managed by the repository . . .Hooks are per-repository and are not designed to be pushed but can be pushed. Similarly, the repo config isn't pushed either, nor is anything in .git/info , or a number of other things. Pushing and pulling only exchanges branches/tags and commit objects (and anything reachable from a commit, e.g. trees, blobs** Add something about creating a symbolic link from ../.git/hooks to this hooks directory that are managed in this repository using markit. 

#### Future Objectives 

- <COMMIT_FILE_NAME>.test-case-input - Add support   #12
- Design for quick test case git branch merge (include steps)
- Quick test case branch merge from test team's custom test cases without merge conflicts (include steps)

      git remote --verbose
      git remote add origin https://github.com/BradleyA/git-TEST-commit.git
      git remote --verbose
      git push -u origin master

      git-TEST-cases.sh -c --hooks

      git branch -a
      git branch git-TEST-commit-#1

      git push origin git-TEST-commit-#1
      git branch -a
      
      #  create a branch
      git pull                      #  get latest pushed commits
      git checkout -b development   #  create development branch
      git push --set-upstream origin development   #  create github development branch upstream (github)
        #  or
      git push -u origin development
        #  write code in development branch
        #  create README on github master branch
      git pull origin master        #  pull chnages to master bransh to development bransh
        #  write code in development branch
      	
    
  - challenge is SA-setup.sh & FVT-setup.sh could be changed by development and test teams 
  - Quick backup of all test cases in repository (\<FILE-NAME>.tar) (code is in uninstall-) (option: --backup --restore)
  - Include support for other test or CI solutions ... Scan for Credentials, BATS, Travis CI, ...

 #### Author
[<img id="twitter" src="hooks/images/twitter.png" width="50" a="twitter.com/bradleyaustintx/">
](https://twitter.com/bradleyaustintx/)   [<img id="github" src="hooks/images/github.png" width="50" a="https://github.com/BradleyA/">
](https://github.com/BradleyA/)    [<img src="hooks/images/linkedin.png" style="max-width:100%;" >](https://www.linkedin.com/in/bradleyhallen)

#### System OS script tested
 * Ubuntu 16.04.6 LTS (GNU/Linux 4.4.38-v7+ armv7l)
 * Ubuntu 14.04.6 LTS (GNU/Linux 4.4.0-148-generic x86_64)

#### Design Principles
 * Have a simple setup process and a minimal learning curve
 * Be usable as non-root
 * Be easy to install and configure

## License
MIT License

Copyright (c) 2019 [Bradley Allen](https://www.linkedin.com/in/bradleyhallen)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
