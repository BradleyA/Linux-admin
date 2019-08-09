### in design & development

<img alt="Clones" src="https://img.shields.io/static/v1?label=Clones&message=32&color=blue"> <img alt="Views"  src="https://img.shields.io/static/v1?label=Views&message=312&color=blue">

 <img alt="gitlab"  src="https://img.shields.io/static/v1?logo=gitlab&&message=26,24,1&color=blue">
 
### Clone

To install, change **BradleyA** to your Github repository owner name or who you signed in as on Github. Use git to pull or clone these scripts into the directory. If you do not have git then enter; "sudo apt-get install git". On the github page of this script use the "HTTPS clone URL" with the 'git clone' command.

    cd /tmp
    git clone https://github.com/BradleyA/Linux-admin
    cd Linux-admin/github-repository
    ./setup.github.repository.sh BradleyA
    cd ../..
    rm -rf Linux-admin/
    cd /usr/local/data/github/

Add lines to crontab

    crontab -e
   
Edit ~/.netrc or what ever solution you use for authentication  (No you don't push any file like this to anywhere. Duh!)     
    
    vi ~/.netrc
    chmod 600 ~/.netrc
    
    
    machine api.github.com login <github-owner-account-name> password <secret-github-password>

### FILE Definition and ARCHITECTURE TREE

To set github login to support automation of script running on system 'two' in crontab by editing file, ~/.netrc

    machine api.github.com login BradleyA password secret-not-known-to-you

For each repository that requires their data to be pulled will need a file that is formatted like repository:owner-repository and rm -rf Linux-admin/contains the git commands.

    #!/bin/bash
    ###	BradleyA.Search-docker-registry-v2-script.1.0
    . . . 

#### Traffic

 * <img alt="Clones" src="https://img.shields.io/static/v1?label=Clones&message=29&color=blue">  [Clones Table](images/clone.table.md)
 * <img alt="Views" src="https://img.shields.io/static/v1?label=Views&message=203&color=blue">  [Views Table](images/view.table.md)

#### Author
[<img id="twitter" src="../images/twitter.png" width="50" a="twitter.com/bradleyaustintx/">
](https://twitter.com/bradleyaustintx/)   [<img id="github" src="../images/github.png" width="50" a="https://github.com/BradleyA/">
](https://github.com/BradleyA/)    [<img src="../images/linkedin.png" style="max-width:100%;" >](https://www.linkedin.com/in/bradleyhallen)

#### System OS script tested
 * Ubuntu 14.04.3 LTS
 * Ubuntu 16.04.3 LTS (armv7l)

#### Design Principles
 * Have a simple setup process and a minimal learning curve
 * Be usable as non-root - failed adminstration requires root
 * Be easy to install and configure

#### Git clones
Date:|  07-15 | 07-22 | 07-29|  07-15 | 07-22 | 07-29|  07-15 | 07-22 | 07-29|  07-15 | 07-22 | 07-29
---       |    ---:|   ---:| ---: |    ---:|   ---:| ---: |    ---:|   ---:| ---: |    ---:|   ---:| ---: 
Clones:     | 1      |27     |     1| 1      |   27  |     1| 1      |   27  |   1  | 1      |   27  |   1 
Unique clones:   | 1      |2      |   1  | 1      |   2   |     1| 1      |   2   |     1| 1      |   2   |   1

Total clones: 32

#### Visitors
Date:|  07-15 | 07-22 | 07-29|  07-15 | 07-22 | 07-29|  07-15 | 07-22 | 07-29|  07-15 | 07-22 | 07-29
---       |    ---:|   ---:| ---: |    ---:|   ---:| ---: |    ---:|   ---:| ---: |    ---:|   ---:| ---: 
Views:     | 1      |27     |     1| 1      |   27  |     1| 1      |   27  |   1  | 1      |   27  |   1 
Unique vistors:   | 1      |2      |   1  | 1      |   2   |     1| 1      |   2   |     1| 1      |   2   |   1

Total views: 312

## License
MIT License

Copyright (c) 2019  [Bradley Allen](https://www.linkedin.com/in/bradleyhallen)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
