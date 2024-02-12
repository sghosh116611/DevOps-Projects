#!/bin/bash

set -eo pipefail
## Author : Soumojit Ghosh
## Date : 12/02/2024
### This script lists down the collaborators of a particular repository - provided that you have sufficient access to the repository

API_URL="https://api.github.com/repos"

REPO_OWNER=$1
REPO_NAME=$2

if [[ -z "$REPO_OWNER" ||  -z "$REPO_NAME" ]]
then
        echo "Empty Arguments"
        exit 1
fi;

TOKEN=$GitHub_Token

function github_api_get {
        local endpoint="$1"
        local url="${API_URL}/${endpoint}"
}

function list_users_with_read_access {
        local endpoint="/${REPO_OWNER}/${REPO_NAME}/collaborators"

        # Fetch the list of collaborators
        collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == "true" | .login)')"

        if [ -z "$collaborators" ];
                then
                        echo "Empty collaborators"
                else
                        echo ${collaborators}
        fi
}

list_users_with_read_access