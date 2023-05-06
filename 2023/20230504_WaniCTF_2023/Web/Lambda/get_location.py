import sys
import re
import boto3

if len(sys.argv) < 2:
	print("specify CSV file path")
	sys.exit(1)

csv = open(sys.argv[1], "rb").read()[3:].decode().split("\n")
key_id, key, region = csv[1].rstrip().split(",")

print("Access key ID = " + key_id)
print("Secret access key = " + key)
print("Region = " + region)

lam = boto3.client(
	'lambda',
	aws_access_key_id=key_id,
	aws_secret_access_key=key,
	region_name=region
)

api = boto3.client(
	'apigateway',
	aws_access_key_id=key_id,
	aws_secret_access_key=key,
	region_name=region
)

rest_api = api.get_rest_apis()
api_id = rest_api["items"][0]["id"]
print("restApiId = " + api_id)

resource = api.get_resources(restApiId=api_id)
resource_id = resource["items"][0]["id"]
method = list(resource["items"][0]["resourceMethods"].keys())[0]
print("resourceId = " + resource_id)
print("httpMethod = " + method)

integration = api.get_integration(
	restApiId=api_id,
	resourceId=resource_id,
	httpMethod=method
)
uri = integration["uri"]
function_name = re.compile("function:([^/]+)/").search(uri).groups()[0]
print("uri = " + uri)
print("FunctionName = " + function_name)

function = lam.get_function(FunctionName=function_name)
location = function["Code"]["Location"]
print("Location = " + location)
