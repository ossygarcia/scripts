#!/bin/bash

# Set AWS region and DynamoDB table name
AWS_REGION=us-west-2
TABLE_NAME=xoe_flavor_tree_stg

# Read the JSON file containing the request items into a variable
REQUEST_ITEMS=$(cat xoe_flavor_tree_stg.json)

# Split the request items into chunks of 25
CHUNKS=$(echo $REQUEST_ITEMS | jq -c '.[]' | split -l 25 -)

# Loop through the chunks and upload each one to DynamoDB using the batch-write-item command
for chunk in $CHUNKS; do
  REQUEST="{\"$TABLE_NAME\": $(echo $chunk | jq -c 'map({"PutRequest": {"Item": .}})')"
  aws dynamodb batch-write-item --region $AWS_REGION --request-items $REQUEST
done
