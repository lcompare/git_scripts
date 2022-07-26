#!/bin/bash
#script to pull from all repositories in a directory

force="false"

while getopts b:f flag
do
    case "${flag}" in
        b) branch=${OPTARG};;
        f) force="true";;
    esac
done

if [ -z "$branch" ]
  then
   echo "provide branch as an argument with: -b branch_name"
    exit 1
fi

curr_dir=$(pwd)
dir_count=$(ls -l | grep -c ^d)
RED='\033[0;31m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color

q_continue () {
  read -p "Continue? " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
    exit 1
  fi

  echo
  echo
}

git_pull (){
  git checkout "$branch"
  echo "git pull"
  git pull
  echo
  if [[ "$2" < "$dir_count" ]] && [[ $force == "false" ]]; then q_continue; fi
}

i=0
for d in */ ; do
  ((i=i+1))
  echo
  printf "${GREEN}*** ${d%?} ***${NC}\n"
  echo "repo $i of $dir_count"
  echo "cd $curr_dir/$d"
  cd "$curr_dir/$d"
  git_pull $branch $i $force
done