#!/bin/bash

# kill old process
id=`pgrep -f run.rb`
kill -9 $id

# pull from repo
git pull origin master
bundle install
rake db:migrate

# run in background
nohup ./run.rb 0<&- &> logs/log.txt &
