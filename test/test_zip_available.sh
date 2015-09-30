#!/bin/bash

set -e

mkdir -p /deploy/tmp
zip -r /deploy/tmp/upload_to_s3.zip /deploy/test/upload_to_s3
