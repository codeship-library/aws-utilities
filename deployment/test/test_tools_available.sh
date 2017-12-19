#!/bin/bash

set -e
set -o pipefail

mkdir -p /deploy/tmp

# Test that Zip is Available
zip -r /deploy/tmp/upload_to_s3.zip /deploy/test/upload_to_s3

# Test that JQ is available and works
echo "{\"test\": \"result\"}" | jq ".test" | grep "result"
