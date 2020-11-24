require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'aws-sdk-core'

$role_credentials = Aws::AssumeRoleCredentials.new(
  role_arn: ENV['ROLE_ARN'],
  role_session_name: "aws-credentials-server"
)

configure do
  set :bind, "0.0.0.0"
  set :port, "80"
end

get '/' do
  'aws-credentials-server'
end

get '/latest/meta-data/iam/security-credentials/?' do
  'local-credentials'
end

get '/latest/meta-data/iam/security-credentials/local-credentials' do
  content_type :json
  credentials
end

get '/latest/meta-data/instance-id/?' do
  'aws-credentials-server'
end

get '/latest/meta-data/iam/info/?' do
  content_type :json
  '{"Code": "Success"}'
end

get '/latest/meta-data/dynamic/instance-identity/document' do
  content_type :json
  {
    region: ENV['AWS_REGION']
  }.to_json
end

def credentials
  creds = $role_credentials.credentials
  expiry = $role_credentials.expiration

  {
    Code: "Success",
    LastUpdated: Time.now.utc.iso8601,
    Type: "AWS-HMAC",
    AccessKeyId: creds.access_key_id,
    SecretAccessKey: creds.secret_access_key,
    Token: creds.session_token,
    Expiration: expiry.iso8601
  }.to_json
end
