set :user, 'ubuntu'
server 'ec2-52-10-164-28.us-west-2.compute.amazonaws.com', :app, :web, :db, primary: true
ssh_options[:keys] = ['~/.jCriAWSkey.pem']
