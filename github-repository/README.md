### in design & development

testing >>>
<src="NOTES"  >
 
### Clone

To install, change **BradleyA** to your Github repository owner name or who you signed in as on Github. Use git to pull or clone these scripts into the directory. If you do not have git then enter; "sudo apt-get install git". On the github page of this script use the "HTTPS clone URL" with the 'git clone' command.

    cd /tmp
    git clone https://github.com/BradleyA/Linux-admin
    cd Linux-admin/github-repository
    ./setup.github.repository.sh BradleyA
    cd ../..
    rm -rf Linux-admin/

To run
    
    edit crontab -e and add lines
    do something to have cron reread if needed to work ???? think not need to check pi-display code
    add ~/.netrc
    chmod 600 ~/.netrc
    machine api.github.com login <github-owner-account-name> password <secret-github-password>
    
    

### FILE Definition and ARCHITECTURE TREE

To set github login to support automation of script running on system 'two' in crontab by editing file, ~/.netrc

    machine api.github.com login BradleyA password secret-not-known-to-you

For each repository that requires their data to be pulled will need a file that is formatted like repository:owner-repository and rm -rf Linux-admin/contains the git commands.

    #!/bin/bash
    ###	BradleyA.Search-docker-registry-v2-script.1.0
    . . . 


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

## License
MIT License

Copyright (c) 2019  [Bradley Allen](https://www.linkedin.com/in/bradleyhallen)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
