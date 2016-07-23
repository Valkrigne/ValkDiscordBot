if [[ -e app/config/database.yml ]]; then
  echo 'database.yml already exists, skipping...'
else
  echo 'Creating local copy of database.yml...'
  cp app/config/database.example.yml app/config/database.yml
  echo 'Edit config/database.yml to match your local setup'
fi

if [[ -e app/config/application.yml ]]; then
  echo 'application.yml already exists, skipping...'
else
  echo 'Copying local copy of application.yml...'
  cp app/config/application.example.yml app/config/application.yml
  echo 'Edit config/application.yml to match your local setup'
fi
