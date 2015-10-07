function eb_describe(){
  aws elasticbeanstalk describe-environments --application-name "$APPLICATION_NAME" --environment-names "$ENVIRONMENT_NAME"
}

function environment_status(){
  echo "$(eb_describe)" | jq -r .Environments[0].Status
}

function environment_health(){
  echo "$(eb_describe)" | jq -r .Environments[0].Health
}

function environment_version(){
  echo "$(eb_describe)" | jq -r .Environments[0].VersionLabel
}

function environment_cname(){
  echo "$(eb_describe)" | jq -r .Environments[0].CNAME
}
