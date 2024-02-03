#!/bin/sh

# Load environment variables
source .env

# Create a snapshot
curl -X PUT "http://elasticsearch:9200/_snapshot/my_backup/snapshot_$(date +%Y%m%d)" -u $ELASTIC_USERNAME:$ELASTIC_PASSWORD -H 'Content-Type: application/json' -d'
{
  "indices": "*",
  "ignore_unavailable": true,
  "include_global_state": false
}'

# Delete snapshots older than 7 days
curl -X DELETE "http://elasticsearch:9200/_snapshot/my_backup/snapshot_$(date -d "-7 days" +%Y%m%d)" -u $ELASTIC_USERNAME:$ELASTIC_PASSWORD

# Upload the snapshot to S3
s3cmd put /path/to/snapshot s3://$S3_BUCKET_NAME/ --access_key=$S3_ACCESS_KEY --secret_key=$S3_SECRET_KEY --host=$S3_ENDPOINT --host-bucket=$S3_BUCKET_NAME.$S3_ENDPOINT
