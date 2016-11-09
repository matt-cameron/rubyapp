class InstancesController < ApplicationController

  #require log in
  before_filter :authorize

  def view
   require 'aws-sdk-rails'

   @ec2 = Aws::EC2::Resource.new(region: 'us-east-1')
  end

end
