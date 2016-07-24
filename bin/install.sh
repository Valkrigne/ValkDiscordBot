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

BUNDLE_GEMFILE=Gemfile bundle install
rake db:create db:migrate

# Import the SSH deployment key
openssl aes-256-cbc -K $encrypted_22009518e18d_key -iv $encrypted_22009518e18d_iv -in deploy-key.enc -out deploy-key -d
rm deploy-key.enc # Don't need it anymore
chmod 600 deploy-key
mv deploy-key ~/.ssh/id_rsa
