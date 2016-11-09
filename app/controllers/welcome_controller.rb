class WelcomeController < ApplicationController

  #require log in
  before_filter :authorize


  def index
   require 'aws-sdk-rails'

   @ec2 = Aws::EC2::Resource.new(region: 'us-east-1')
  end

  def stop
   require 'aws-sdk-rails'

   ec2 = Aws::EC2::Resource.new(region: 'us-east-1')
   target = params[:instance]
   i = ec2.instance(target)

   if i.exists?
     case i.state.code
     when 80  # stopped
       puts "#{i.id} is stopped, so you cannot stop it"
     when 48  # terminated
       puts "#{i.id} is terminated, so you cannot start it"
     else
       i.stop
       redirect_to "/"
     end
     end
  end

 def start
   require 'aws-sdk-rails'

   ec2 = Aws::EC2::Resource.new(region: 'us-east-1')
   target = params[:instance]
   i = ec2.instance(target)

   if i.exists?
     case i.state.code
     when 0  # pending
       puts "#{i.id} is pending, so it will be running in a bit"
     when 16  # started
       puts "#{i.id} is already started"
     when 48  # terminated
       puts "#{i.id} is terminated, so you cannot start it"
     else
       i.start
       redirect_to "/"
     end
     end
  end


end
