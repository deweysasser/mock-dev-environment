mock-dev-environment
====================

This project devines a mock build pipeline environment based around
Jenkins, Gitolite, Docker and a private Docker Registry.

THIS IS A WORK IN PROGRESS

It's currently useful but requires a bit of work "out of the box" to
start using it.

The intent of this system is to create an isolated development system
for build development.  It could be used as the basis for an actual
production source code and build system, with appropriate backups and
modifications.  While this could happen, it's not the intent and this
project is not currently moving in that direction.


Installation
------------

Assuming you have 'docker', 'docker-compose' and 'make' available, you
should just be able to type

    make SSH_KEY=$(cat ~/.ssh/id_rsa.pub)

Will get you the set of docker images.  (Or other method of giving it
your SSH key, including the override file).

There are a few other steps:

1) You can use 'docker-compose.override.yml' to specify ports on
Jenkins and Git to expose.  You can edit the override file and just
run `make` again.


2) configure your ~/.ssh/config to have an entry for "localgit" that
points to the host and port of the git container.

3) check out localgit:gitolite-admin and put in the following in the
gitolite.conf file:

    repo [a-zA-Z].*
    RW+     =   @all
    C       =   @all

4) Add the Jenkins container key (from jenkins/ssh/id_rsa.pub) to the
gitolite keys directory.

5) Commit and push the gitolite-admin

6) push something to localgit:testing.git (it will auto-create on push)

6) Edit your jenkins config and give the appropriate tags (probably at
least 'docker') to your master node.

7) Use the canned jobs to make sure everything is working.


The Override File
-----------------

There are a few other things you can do in the
docker-compose.override.yml file:

a) use 'links' to make different names for git and registry.  For
example, if you add:

    jenkins:
       links:
          - git:github.com

Then your pipelines can now check out from "github.com" and it will
actually come from your local git.  Make sure your Jenkins checkout
credentials for your local git have the same /ID/ as the ones you use
on your real Jenkins.

b) Use "ports" to expose ports the way you would like.


Future/TODO
-----------

Things which need to be done here to improve the "Out of the Box"
experience:

* Do the gitolite-admin initialization, either by having a canned
  gitolite-admin or canned repos when we launch the gitolite
  container.  Make it so you can start using the Jenkins jobs right
  out of the box.

* Use docker-in-docker (image docker:dind) instead of the host docker.
  Document using links correctly so that you can also use the local
  docker registry with name aliases the way you can use git.

* Better handling finding the local SSH key. 

* Handle setting up the ~/.ssh/config 

* Create a script that spiders a directory and adds a 'local' git
  remote to every project and pushes it to local.

* Understand non-commaneline-weenie workflows and support them.
