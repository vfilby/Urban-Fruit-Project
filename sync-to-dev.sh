#!/bin/bash
heroku db:pull --confirm=urbanfruitproject
~/Downloads/s3cmd-1.1.0-beta3/s3cmd sync --delete-removed --acl-public s3://urbanfruitproject s3://urbanfruitproject-dev

source .powrc
rake tanker:reindex
rake tanker:functions
