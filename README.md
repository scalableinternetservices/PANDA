### Remote deployment link
http://panda.eba-gaci4fx8.us-west-2.elasticbeanstalk.com/

### Getting Start(to read what already have

(for linux please do docker-compose, for mac please do docker compose without "-")
1. build
```
$ docker-compose build
```
2. drop and recreate and migrate db
```
$ docker-compose run web rake db:drop db:create db:migrate
```
if you wish to use seed file, run
```
$ docker-compose run web rake db:drop db:create db:migrate db:seed
```
3. start the server
```
$ docker-compose up
```
4. put http://0.0.0.0:3000/ in browser, press RETERN


### Main workflow to start contribution
1. create your branch locally
```
$ git branch [username]/[branchname]
```
2. see if your branch created locally
```
$ git branch
```
3. go to your branch
```
$ git checkout [username]/[branchname]
```
4. ***make edits to web content***
5. git add your change
```
$ git add .
```
6. make your message
```
$ git commit -m "[your message]"
```
7. git push
```
$ git push origin [your branch]
```
8. open new pull request
On GitHub page Pull Requests -> new pull request -> change field to "base:main branch <- compare:[yourbranch]"
9. put some message in message box
10. ask for at least 1 reviewer to approve (your teammate)
11. resolve any conflict in local by typing this in your console
```
git pull origin main --rebase
```
Then in the source control on the leftside bar of VSCode, follow the prompt to accept incoming/current change
add all change
make a commit
```
$ git push origin [yourbranch] --force-with-lease
```
12. click merge button in browser to main branch

## Tsung test
1. ssh to remote with PANDA.pem in current directory
```bash
ssh -i PANDA.pem PANDA@ec2.cs291.com
```
2. create a tsung instance (remember to terminate after use)
  - In PANDA@ec2.cs291.com remote, run this, it will open a Tsung instance
```
/bin/launch_tsung.sh
```
  - This command will output a **ssh command (1)** and **a link(2)** 
    **(NOTE:Remember it or write it down somewhere)**
3. type **ssh command(1)** of step 2 in the PANDA@ec2.cs291.com remote, it will open another ssh remote, which is the Tsung remote
4. Now we are in Tsung remote, there should be a example xml tsung test file called tsung_example.xml
5. Put the test file you wrote in root of Tsung remote, run *Replace demo.xml with your tsung test.xml
```
tsung -f demo.xml -k start
```
6. In your favorite browser(Chrome) type in **link(2)** you got from step 2
7. You will see the log and graph and report for tsung
### Save tsung test result 
> It's better to open three terminal 1 for local; 1 for PANDA@ec2.cs291.com; 1 for Tsung instance ec2-user@54.166.5.220
1. Open another ssh remote without terminate previous one
```bash
ssh -i PANDA.pem PANDA@ec2.cs291.com
```
2. Save log: In the new PANDA@ec2.cs291.com instance run *replace ec2-user@54.166.5.220 with [the text after ssh of **ssh command (1)**  you get from step 2 of tsung test](#tsung-test)*
```
rsync -auvL ec2-user@54.166.5.220:tsung_logs .
```
3. Save graphs: 
- In Tsung instance, cd into tsung_logs folder, ls to see the log timestamp name
- Then replace [20171108-2133] and [20171108-2146] with the time stamp name
  ```
  tsplot -d graphs m3_medium ./[20171108-2133]/tsung.log m3_large ./[20171108-2146]/tsung.log
  ```
4. Save log and graph to your local computer
- In Tsung instance ec2-user@54.166.5.220, print directory of graph folder
```
pwd
```
- In PANDA@ec2.cs291.com remote, copy the graph folder from Tsung instance ec2-user@54.166.5.220 to PANDA@ec2.cs291.com remote
Replace [/home/user/graphs] with result of previous step
```
scp -r ec2-user@54.166.5.220:[/home/user/graphs] .
```
run pwd again to see where the graph file is
```
pwd
```
- In console of your local computer, cd into a directory with authorizer of PANDA.pem file then copy the graphs to this directory 
replace [~/graphs] with the location of graph file of previous step
```
scp -r -i PANDA.pem PANDA@ec2.cs291.com:[~/graphs] .
```

### feed database
#### optional
```
docker-compose run web rake db:drop db:create db:migrate
```
run:
```
cd seed
pip3 install requests
python3 seed.py
```


