#!/bin/bash

# kill old process
id=`pgrep -f run.rb`
cmd="kill -9 $id"
eval $cmd

# pull from repo
git pull origin master
bundle install
rake db:migrate

# run in background
echo `nohup ./run.rb 0<&- &> logs/log.txt &`
