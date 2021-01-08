#!/bin/bash

set -e

E_AWS_S3_BUCKET_NOT_SET=1
E_AWS_ACCESS_KEY_ID_NOT_SET=2
E_AWS_SECRET_ACCESS_KEY_NOT_SET=3
E_MYSQL_DATABASE_NOT_SET=4
E_AWS_S3_BACKUP_FILE_NOT_SET=5

if [ -z "$AWS_S3_BUCKET" ]; then
    echo "AWS_S3_BUCKET is not set. Quitting."
    exit $E_AWS_S3_BUCKET_NOT_SET
fi

if [ -z "$AWS_S3_BACKUP_FILE" ]; then
    echo "AWS_S3_BACKUP_FILE is not set. Quitting."
    exit $E_AWS_S3_BACKUP_FILE_NOT_SET
fi

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
    echo "AWS_ACCESS_KEY_ID is not set. Quitting."
    exit $E_AWS_ACCESS_KEY_ID_NOT_SET
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
    echo "AWS_SECRET_ACCESS_KEY is not set. Quitting."
    exit $E_AWS_SECRET_ACCESS_KEY_NOT_SET
fi

if [ -z "$MYSQL_HOST" ]; then
    MYSQL_HOST="localhost"
fi

if [ -z "$MYSQL_PORT" ]; then
    MYSQL_PORT="3306"
fi

if [ -z "$MYSQL_DATABASE" ]; then
    echo "MYSQL_DATABASE is not set. Quitting."
    exit $E_MYSQL_DATABASE_NOT_SET
fi

if [ -z "$MYSQL_USER" ]; then
    MYSQL_USER="root"
fi

if [ -z "$MYSQL_PASSWORD" ]; then
    MYSQL_PASSWORD=""
fi

# Default to us-east-1 if AWS_REGION not set.
if [ -z "$AWS_REGION" ]; then
    AWS_REGION="us-east-1"
fi

# Override default AWS endpoint if user sets AWS_S3_ENDPOINT.
if [ -n "$AWS_S3_ENDPOINT" ]; then
    ENDPOINT_APPEND="--endpoint-url $AWS_S3_ENDPOINT"
fi

export WAIT_HOSTS=$MYSQL_HOST:$MYSQL_PORT

/wait

aws s3 cp s3://$AWS_S3_BUCKET/$AWS_S3_BACKUP_FILE latest.sql
mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --database=$MYSQL_DATABASE --user=$MYSQL_USER --password=$MYSQL_PASSWORD <latest.sql
rm latest.sql
