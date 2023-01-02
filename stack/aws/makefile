#profile
create-profile:
	aws configure --profile $$PROFILE_NAME

create-bucket:
	aws s3 mb s3://$$TF_BUCKET_NAME \
  	--profile $$PROFILE_NAME \
  	--region $$TF_REGION

create-public-access:
	aws s3api put-public-access-block \
	--bucket $$TF_BUCKET_NAME \
	--public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true" \
	--profile $$PROFILE_NAME \
	--region $$TF_REGION

create-encrypt-bucket:
	aws s3api put-bucket-encryption --bucket $$TF_BUCKET_NAME --server-side-encryption-configuration "{\"Rules\": [{\"ApplyServerSideEncryptionByDefault\":{\"SSEAlgorithm\": \"AES256\"}}]}"

create-version:
	aws s3api put-bucket-versioning \
	--bucket $$TF_BUCKET_NAME \
	--versioning-configuration "Status=Enabled" \
	--profile $$PROFILE_NAME \
	--region $$TF_REGION

create-dynamo:
	aws dynamodb create-table \
	--table-name $$TF_BUCKET_NAME \
	--attribute-definitions AttributeName=LockID,AttributeType=S \
	--key-schema AttributeName=LockID,KeyType=HASH \
	--provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
	--profile $$PROFILE_NAME \
	--region $$TF_REGION

terraform-init:
	terraform init -reconfigure \
	-backend-config "bucket=$$TF_BUCKET_NAME" \
	-backend-config "key=tf/$$PROJECT_NAME/terraform.tfstate" \
	-backend-config "region=$$TF_REGION" \
	-backend-config "access_key=$$AWS_ACCESS_KEY_ID" \
	-backend-config "secret_key=$$AWS_SECRET_ACCESS_KEY"