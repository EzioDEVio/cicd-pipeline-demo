

docker build -t cicddemoapp . ### build the image from the dockerfile in the current directory, the image name is cicddemoapp

docker tag cicddemoapp ezio22/cicddemoapp:latest ### tag the image with the repository name, in this case it is ezio22/cicddemoapp, and the tag is latest

docker login ### login to docker hub, you need to have an account on docker hub

docker pull  ezio22/cicddemoapp:latest ### after we build the image we pushed it to docker hub, or coudld be any container registry.

docker run -p 8080:8080 ezio22/cicddemoapp  ### we run the image on port 8080 locally to test it.


 ### pulling from GHCR and run it

## I built an image using github workflow and pushed it to GHCR, the image is available at github packages

 docker pull ghcr.io/eziodevio/ghcr-democicdapp:430e8b34dcb45d41239eab8d1ee1d0b14e3cc3fd430e8b34dcb45d41239eab8d1ee1d0b14e3cc3fd ### pull the image from GHCR

 docker run -p 8080:8080 ghcr.io/eziodevio/ghcr-democicdapp:430e8b34dcb45d41239eab8d1ee1d0b14e3cc3fd ### run the image on port 8080 locally to test it.



 ################################################### GIT OPERATION #######################################################

git status ### check the status of the git repository

git init ### initialize a new git repository

git add filename1 filename2 ### add the files to the staging area

git add . ### add all the files to the staging area

git commit -m "A descriptive message explaining your changes" ### commit the changes to the local repository

git remote add <remote-name> <remote-url> ### add a remote repository

git push origin main ### push the changes to the remote repository

git push origin your-branch-name ### push the changes to the remote repository

git pull origin main ### pull the changes from the remote repository

git pull origin your-branch-name ### pull the changes from the remote repository

git checkout -b your-branch-name ### create a new branch and switch to it

git checkout your-branch-name ### switch to an existing branch

git branch -d your-branch-name ### delete a branch

git branch ### list all the branches

git log ### show the commit history

git log --oneline ### show the commit history in one line

git log --oneline --graph ### show the commit history in one line with a graph

git log --oneline --graph --all ### show the commit history in one line with a graph including all branches

git reset --hard commit-hash ### reset the repository to a specific commit

git reset --hard origin/main ### reset the repository to the remote main branch 

git reset --hard origin/your-branch-name ### reset the repository to the remote branch

git reset --hard HEAD ### reset the repository to the last commit

git reset --hard HEAD~1 ### reset the repository to the commit before the last commit

git reset --hard HEAD~n ### reset the repository to the commit before the last n commits

git reset --hard HEAD^ ### reset the repository to the commit before the last commit

git reset --hard HEAD^n ### reset the repository to the commit before the last n commits

git reset --hard HEAD@{1} ### reset the repository to the commit before the last commit

git clone <repository-url> ### clone a remote repository to your local machine

git clone <repository-url> <folder-name> ### clone a remote repository to a specific folder on your local machine

git branch -r ### list all the remote branches

git branch -a ### list all the local and remote branches

git checkout -b <new-branch-name> origin/<remote-branch-name> ### create a new branch and switch to it, based on a remote branch

git fetch ### fetch the latest changes from the remote repository

git merge <branch-name> ### merge changes from a different branch into the current branch

git diff ### show the differences between the working directory and the last commit

git diff --staged ### show the differences between the staging area and the last commit

git stash ### temporarily save changes that are not ready to be committed

git stash apply ### apply the most recent stash

git stash list ### list all the stashes

git stash drop ### remove the most recent stash

git remote -v ### list all the remote repositories

git remote remove <remote-name> ### remove a remote repository

git remote rename <old-name> <new-name> ### rename a remote repository

git remote set-url <remote-name> <new-url> ### change the URL of a remote repository

git tag ### list all the tags

git tag <tag-name> ### create a new tag

git tag -a <tag-name> -m "Tag message" ### create an annotated tag with a message

git push origin --tags ### push all the tags to the remote repository

git push origin :<tag-name> ### delete a tag from the remote repository

git show <commit-hash> ### show the details of a specific commit

git blame <file-name> ### show who made the last changes to each line of a file

git cherry-pick <commit-hash> ### apply the changes from a specific commit to the current branch

git rebase <branch-name> ### move the current branch to the tip of another branch

git reset <file-name> ### unstage a file

git reset --hard ### discard all the changes and reset to the last commit

git clean -f ### remove untracked files from the working directory

git config --global user.name "Your Name" ### set your name for commit messages

git config --global user.email "your-email@example.com" ### set your email for commit messages



###########################################################################################################################




 ################################################### DOCKER OPERATION #######################################################

docker ps ### list all the running containers

docker ps -a ### list all the containers

docker images ### list all the images

docker build -t image-name . ### build an image from the dockerfile in the current directory

docker run -p host-port:container-port image-name ### run a container from an image

docker run -p 8080:8080 image-name ### run a container from an image on port 8080

docker run -d image-name ### run a container in detached mode

docker exec -it container-id /bin/bash ### execute a command in a running container

docker stop container-id ### stop a running container

docker rm container-id ### remove a container

docker rmi image-id ### remove an image

docker pull image-name ### pull an image from a registry

docker push image-name ### push an image to a registry

docker login ### login to a container registry

docker tag image-name registry/image-name ### tag an image with a registry

docker-compose up ### start the services defined in a docker-compose file

docker-compose down ### stop the services defined in a docker-compose file

docker-compose ps ### list the services defined in a docker-compose file

docker-compose logs ### show the logs of the services defined in a docker-compose file

docker-compose exec service-name command ### execute a command in a service defined in a docker-compose file

docker-compose build ### build the services defined in a docker-compose file

docker-compose pull ### pull the images for the services defined in a docker-compose file

docker-compose push ### push the images for the services defined in a docker-compose file

docker-compose stop ### stop the services defined in a docker-compose file

docker-compose rm ### remove the services defined in a docker-compose file

docker-compose restart ### restart the services defined in a docker-compose file

docker-compose up -d ### start the services defined in a docker-compose file in detached mode

docker-compose down -v ### stop the services defined in a docker-compose file and remove the volumes

docker-compose up -d --build ### start the services defined in a docker-compose file in detached mode and rebuild the images

docker-compose up -d service-name ### start a specific service defined in a docker-compose file in detached mode

docker-compose down service-name ### stop a specific service defined in a docker-compose file

docker-compose logs service-name ### show the logs of a specific service defined in a docker-compose file

docker-compose exec service-name command ### execute a command in a specific service defined in a docker-compose file

docker-compose build service-name ### build a specific service defined in a docker-compose file

docker-compose pull service-name ### pull the image for a specific service defined in a docker-compose file

docker-compose push service-name ### push the image for a specific service defined in a docker-compose file



