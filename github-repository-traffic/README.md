# github-repository-traffic 

This subdirectory contains shell scripts that download traffic information before it is lost on GitHub.  Most scripts in this repository support --help and --usage options.

### Install

To install, follow these steps.  Use git to pull or clone these scripts into a directory. If you do not have git then enter; "sudo apt-get install git". On the GitHub page of this script use the "HTTPS clone URL" with the 'git clone' command.

    cd /tmp
    git clone https://github.com/BradleyA/Linux-admin
    cd Linux-admin/github-repository-traffic
    
1) Change **BradleyA** below to your GitHub repository owner name or who you signed in as on GitHub
2) Change the lines in github.repository.list file to your GitHub repository names.

       vi ./github.repository.list

3) Run the following to setup the GitHub repository traffic.
       
       ./setup.github.repository.sh BradleyA

## Output
<img id="setup.github.repository.sh" src="../images/setup.github.repository.gif" >

    cd ../..
    rm -rf Linux-admin/
    cd /usr/local/data/github/

4) Enter crontab -e to add the lines from setup.github.repository.sh to crontab 

    crontab -e
   
5) To set GitHub login to support automation of scripts running in cron, edit ~/.netrc and add a personal access token for authentication from GitHub. [Creating a personal access token for the command line.](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line)   No you don't push any file like ~/.netrc to anywhere. Duh!
    
    vi ~/.netrc
       machine api.github.com login BradleyA password <secret-github-token>
    chmod 600 ~/.netrc

### ARCHITECTURE TREE
    /usr/local/data/                           <-- <DATA_DIR>
    └── github                                 <-- Github repository traffic
        ├── clone.heading                      <-- Clone table headings
        ├── github.repository.list             <-- Github repository names
        ├── owner.repository                   <-- Default cron job for repositpry
        │                                          download of clone and views data
        ├── parse.repository.data.sh           <-- Parse relevant data out of cron
        │                                          job data files
        ├── setup.github.repository.sh         <-- Setup github repository data
        │                                          tools
        ├── view.heading                       <-- View table headings
        └── <GITHUB_OWNER>                     <-- Github repository traffic data

#### Traffic

 * <img alt="Clones" src="https://img.shields.io/static/v1?label=Clones&message=77&color=blue">  [Clones Table](images/clone.table.md)
 * <img alt="Views" src="https://img.shields.io/static/v1?label=Views&message=446&color=blue">  [Views Table](images/view.table.md)

#### In design & development  (7/2019)
 
**WARNING**: These instructions below are incomplete. Consider them as notes quickly drafted on a napkin rather than proper documentation!
 
#### Quick Notes:
    cd uadmin@two: /usr/local/data/github/BradleyA/Search-docker-registry-v2-script.1.0
    rm clone.table.md view.table.md   # this is not required, only process the latest files by cron or docker in future
     ../../parse.repository.data.sh BradleyA.Search-docker-registry-v2-script.1.0.2019-07-29
    ../../parse.repository.data.sh BradleyA.Search-docker-registry-v2-script.1.0.2019-08-05
    . . .
    cat clone.table.md
    cat view.table.md

#### Git clones
Date:    |        07-29   |       08-05   |       08-12   |       08-19  |  08-26  |  09-02  |  09-09
|:---    |:---:   |:---:  |:---:  |:---:  |:---:  |:---:  |:---:
Clones:  |        34      |       31      |       2       |       2      |  4      |  2      |  2
Unique   clones:  |       2       |       3       |       2       |      2  |      2  |      2  |      2

Total clones: 77
###### Updated: 2019-12-23

#### Visitors
Date:   |         07-22   |       07-29   |       08-05   |       08-12   |       08-19   |  08-26  |  09-23  |  09-30  |  10-07  |  10-14
|:---   |:---:    |:---:  |:---:  |:---:  |:---:  |:---:  |:---:  |:---:  |:---:  |:---:
Views:  |         2       |       139     |       273     |       2       |       2       |  14     |  6      |  2      |  1      |  5
Unique  vistors:  |       2       |       2       |       3       |       1       |       1  |      2  |      2  |      2  |      1  |      1

Total views: 446
###### Updated: 2019-12-23

#### Author
[<img id="twitter" src="../images/twitter.png" width="50" a="twitter.com/bradleyaustintx/">
](https://twitter.com/bradleyaustintx/)   [<img id="github" src="../images/github.png" width="50" a="https://github.com/BradleyA/">
](https://github.com/BradleyA/)    [<img src="../images/linkedin.png" style="max-width:100%;" >](https://www.linkedin.com/in/bradleyhallen)

#### System OS script tested
 * Ubuntu 14.04.3 LTS
 * Ubuntu 16.04.3 LTS (armv7l)

#### Design Principles
 * Have a simple setup process and a minimal learning curve
 * Be usable as non-root
 * Be easy to install and configure

## License
MIT License

Copyright (c) 2019  [Bradley Allen](https://www.linkedin.com/in/bradleyhallen)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
