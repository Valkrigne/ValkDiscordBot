#!/bin/bash

LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})
BASE=$(git merge-base @ @{u})

if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"
elif [ $LOCAL = $BASE ]; then
  # kill old process
  id=`pgrep -f run.rb`
  cmd="kill -9 $id"
  eval $cmd

  # pull from repo
  git pull origin master
  bundle install
  rake db:migrate

  # run in background
  `chmod +x run.rb`
  `nohup ./run.rb 0<&- &> logs/log.txt &`
fi
