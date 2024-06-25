#!/bin/bash

usage() {
  echo "Usage: $0 --repo <owner/repository> --env <environment>"
  exit 1
}


while [[ "$#" -gt 0 ]]; do
  case $1 in
    --repo) REPO="$2"; shift ;;
    --env) ENVIRONMENT="$2"; shift ;;
    *) usage ;;
  esac
  shift
done


if [ -z "$REPO" ] || [ -z "$ENVIRONMENT" ]; then
  usage
fi


while IFS= read -r line || [ -n "$line" ]; do
  if [[ ! "$line" =~ ^# && "$line" != "" ]]; then
    IFS='=' read -r key value <<< "$line"
    gh secret set "$key" --body "$value" --repo "$REPO" --env "$ENVIRONMENT"
    echo "Set variable $key in repo $REPO for environment $ENVIRONMENT"
  fi
done < .env
