# Downloads and restores mysql-dump from AWS S3

## How to use

```yaml
  s3-restore-mysql-backup:
    image: qortex/s3-restore-mysql-backup:stable
    environment:
      MYSQL_HOST: somehost #required, defaults to localost
      MYSQL_PORT: someport #required, defaults to 3306
      MYSQL_DATABASE: somedatabase #required, points to database to restore dump into
      MYSQL_USER: someuser #optional, defaults to root
      MYSQL_PASSWORD: somepassword #optional, defaults to empty password
      AWS_ACCESS_KEY_ID: someaccesskeyid #required
      AWS_SECRET_ACCESS_KEY: somesecretaccesskey #required
      AWS_DEFAULT_REGION: someregion #opional, defaults to us-east-1
      AWS_S3_BUCKET: somebucket #required, s3 bucket to restore backup from
      ASW_S3_BACKUP_FILE: some3spath #required, s3 path to restore backup from
```