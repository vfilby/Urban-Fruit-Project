#!/bin/bash
rake db:drop
heroku db:pull --confirm=urbanfruitproject
rake db:migrate
./script/s3cmd-1.1.0-beta3/s3cmd sync --delete-removed --acl-public s3://urbanfruitproject s3://urbanfruitproject-dev

source .powrc
rake tanker:reindex
rake tanker:functions
