# cluster-command.CHANGELOG.md

Use the following example to guide you to; How to download an earlier release.

    git clone https://github.com/BradleyA/<REPOSITORY>.git --branch 2.42

**COMING SOON -->**
## Version  {Next Version  3.1.????}  
#### Release Name  {unreleased alpha beta prerelease latest}
#### Release Date  ?????????????

Brief description

### Features Added
* Update issue templates
* Update README.md
* cluster-command
  * cluster-command/cluster-command.sh   add support for production standard 8.0 --usage close #28 
  * cluster-command/cluster-command.sh   upgrade to Production standard 1.3.496 DEBUG variable ; shellcheck version section corrected
  * cluster-command/cluster-command.sh   upgrade or add  1.3.531 DEBUG variable, 8.3.530 --usage, 0.3.214 --help, 4.3.534 Documentation Language, 9.3.513 Parse CLI options and arguments, 7.0 Default variable value
* github-repository-traffic
  * added github-repository README to support design process
  * change data directory to /usr/local/data/github/${DEFAULT_REPOSITORY_OWNER}/${DEFAULT_REPOSITORY}
  * new directory structure to ${DEFAULT_DATA_GITHUB_DIR}/${GITHUB_OWNER}/{log,data} to manage data & commands
  * changed DATA_DIR to DATA_GITHUB_DIR
  * github-repository/setup.github.repository.sh  added requirements checking with help if not met
  * move the echo help hint above the LOOP so user can copy ALL crontab lines at one time
  * github.repository.list   create example file with github repository names with one on each line
  * github-repository/setup.github.repository.sh  changed ln -s to ln-sf to force ln and stop error message File exists
  * github-repository/parse.repository.data.sh  parse data to be used in table
  * github-repository/setup.github.repository.sh  add code for clone.heading & view.heading
  * github-repository/parse.repository.data.sh  total clones include total in clone.total
  * github-repository/parse.repository.data.sh  add totals to tables
  * Create clone.table.md
  * Create view.table.md
  * github-repository-traffic/parse.repository.data.sh   create display_help description
  * github-repository-traffic/parse.repository.data.sh   check if filename not found; ERROR; exit 1; exit 1
  * github-repository-traffic/parse.repository.data.sh   add DEBUG around rm to preventing from being removed when DEBUG is not equal to 0
  * github-repository-traffic/setup.github.repository.sh   setup GITHUB_OWNER environment variable
  * github-repository-traffic/setup.github.repository.sh   update display_help
  * github-repository-traffic/parse.repository.data.sh   complete display_help SEE ALSO
  * github-repository-traffic/setup.github.repository.sh   Upgrade all Production standards
  * github-repository-traffic/parse.repository.data.sh   [clone,view].data.\* files exists and size greater than zero
* github-animated-GIF

### Issues
* cluster-command
  * close #28 cluster-command/cluster-command.sh - add support for production standard 8.0 --usage
* github-repository-traffic
  * close #29 change data directory to /usr/local/data/github/${DEFAULT_REPOSITORY_OWNER}/${DEFAULT_REPOSITORY}
  * close #33 github-repository-traffic/parse.repository.data.sh   create display_help description
  * close #34 github-repository-traffic/setup.github.repository.sh   setup GITHUB_OWNER environment variable
  * close #35 github-repository-traffic/parse.repository.data.sh    check if filename not found; ERROR; exit 1; exit 1
  * close #36 github-repository-traffic/parse.repository.data.sh   add DEBUG around rm to preventing from being removed when DEBUG is not equal to 0
  * close #38 github-repository-traffic/parse.repository.data.sh   complete display_help SEE ALSO
  * close #39 github-repository-traffic/parse.repository.data.sh   [clone,view].data.\* files exists and size greater than zero close
  * close #41 github-repository-traffic/setup.github.repository.sh   update display_help
  * close #42 github-repository-traffic/setup.github.repository.sh   Upgrade all Production standards
* github-animated-GIF


**Latest Release -->**
## Version  2.42.202
#### Release Name  2.42
#### Release Date  2019-06-07T17:09:06.723711-05:00 (CDT)

Minor update to Docker commands

### Features Added
* Update README.md
* update docker section
* add support for production standard 8.0 --usage
* rename several docker sub commands

### Issues
* close #27 rename several docker sub commands
* close #28 add support for production standard 8.0 --usage


## Version  2.38.194
#### Release Name  2.38
#### Release Date  2019-05-26T18:54:39.460128-05:00 (CDT)

correct incidents with <REMOTE_COMMAND_OPTION>

### Features Added
* Update README.md
* update display_help
* correct logic for cluster-command.sh with <REMOTE_COMMAND_OPTION> 
* update display_help for cluster-command.sh to unclude [<REMOTE_COMMAND_OPTION>] 

### Issues
* close #22 correct logic for cluster-command.sh with <REMOTE_COMMAND_OPTION>
* close #25 update display_help for cluster-command.sh to unclude [<REMOTE_COMMAND_OPTION>]


## Version  2.34.185
#### Release Name  2.34
#### Release Date  2019-05-21T14:02:56.051905-05:00 (CDT)

Create new release

### Features Added
* add SOFTWARE ARCHITECTURE to display_help
* upgrade with template standards
* update display_help passphrase and password prompting
* correct incident using SYSTEMS file with special, need more testing
* added two additional DEBUG lines
* cluster-command.sh - disable/enable user login account 
* cluster-command.sh - add logic to support local system not in SYSTEMS… 
* Update README.md

### Issues
- close #21 cluster-command.sh - disable/enable user login account
- close #23 tested with template standards
- close #24 added two additional DEBUG lines


## Version  2.25.144
#### Release Name  beta-2
#### Release Date  2019-01-23T15:46:18.461244-06:00 (CST)

improve help

### Features Added
* Update License with MIT License notice 1/2019
* Add LICENSE file
* Update README.md
* updated display_help
* production standard 4 Internationalizing display-help
* change docker version to display both for user & server
* cluster-command/cluster-command.sh update local host last
* cluster-command.sh --> production standard 5 include Copyright notice

### Issues
* close #18 cluster-command/cluster-command.sh update local host last
* close #19 cluster-command.sh --> production standard 5 include Copyright notice 


## Version  2.06.115
#### Release Name  beta-1
#### Release Date  2018-08-19_18:14:56_CDT

minor changes

### Features Added
* remote -p 22 because ssh port number is controlled by ~/.ssh/config file
* sync to Production standard script design changes
* add # of upgrades requirted after apt-get update
* format output for apt-get upgrade
* Update README.md


## Version  1.21.106
#### Release Name  alpha-3
#### Release Date  2018-07-30_19:07:28_CDT

add port option -p to ssh command

### Features Added
* Update README.md
* add Amazon EC2 private DNS example
* Update SYSTEMS
* change default directory name to /usr/local/data/us-tx-cluster-1/SYSTEMS to support scaling this process
* Change cluster-1 to us-tx-cluster-1
* changed order of options, updated help, added poweroff
* add port option -p to ssh command
* remote -p 22 because ssh port number is controlled by ~/.ssh/config file
* sync to iProduction standard script design changes
* add # of upgrades requirted after apt-get update
* format output for apt-get upgrade
* updated --help
* Change echo or print DEBUG INFO WARNING ERROR
* update display_help
* create a setup script for SYSTEMS etc
* added nano seconds to time
* added DEBUG environment variable, include process ID in ERROR, INFO, WARN, DEBUG statements, display_help | more , shellcheck close #15
* correct incident of not creating directory if missing
* add options support REMOTECOMMANDOPTION
* test environment variables and CLI options

### Issues
* close #10 create a setup script for SYSTEMS etc
* close #11 changed order of options, updated help, added poweroff
* close #13 Change echo or print DEBUG INFO WARNING ERROR
* close #14 test environment variables and CLI options
* close #15 added DEBUG environment variable, include process ID in ERROR, INFO, WARN, DEBUG statements, display_help | more , shellcheck
* close #16 correct incident of not creating directory if missing
* close #17 add options support REMOTECOMMANDOPTION


## Version  1.16.91
#### Release Name  alpha-3
#### Release Date  2018-03-18_13:17:40_CDT

added require-update to require-upgrade

### Features Added
* added require-update to require-upgrade

### Issues

## Version  1.15.90
#### Release Name  alpha-2
#### Release Date 2018-03-14_21:05:05_CDT

modify command download in README 

### Features Added
* Update README.md
* merge cpu-temperature and syste-stats project into this repository
* mv to SYSTEMS file and change location to /usr/local/data/cluster-1
* modify command download in README

### Issues
* close #9 mv to SYSTEMS file and change location to /usr/local/data/cluster-1


## Version  1.13.60
#### Release Name  alpha
#### Release Date 2018-02-23_16:24:00_CST

debug new commands on two cluster

### Features Added
* complete display-help
* set default location for host file
* Update README.md
* stop ssh for local host 
* add command output example
* add docker-release
* added more commands
* determine if host is on-line

### Issues
* close #3 set default location for host file
* close #4 complete display-help
* close #7 stop ssh for local host


## Version  1.4.34
#### Release Name  unreleased
#### Release Date 2018-02-21_21:22:51_CST

ruff draft

### Features Added
* updated script to skip local host until after the loop is completed and correct test on the if statement
* add version to file from markit
* removed cd $HOME/... from clone section
* added description comment
* Update README.md
* change name cluster-shutdown to cluster-command
* comment out x86 hosts so I will not shutdown production cluster during testing
* cluster-shutdown.sh use host list file closes #1 support several commands closes #2
* display_help cpu-temperature.sh & system-stats-1.sh

### Features Deprecations
* change name cluster-shutdown to cluster-command

### Issues
* close #1 cluster-shutdown.sh use host list file
* close #2 cluster-shutdown.sh change scope to support several cluster commands


## Version  {Next Version  X.X.????}  
#### Release Name  {unreleased alpha beta prerelease latest}
#### Release Date  ????????????

Brief description

### Features Added
### Features Changes
### Features Deprecations
### Issues
### Misc