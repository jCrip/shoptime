set :stage, :production
server 'ec2-52-10-164-28.us-west-2.compute.amazonaws.com', user: 'ubuntu', roles: %w{web app db}, primary: true
set :rails_env, 'production'