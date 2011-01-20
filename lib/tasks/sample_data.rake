require 'faker'

namespace :db do
          desc "Fill dabase with sample data"
          task :populate => :environment do
          Rake::Task['db:reset'].invoke
          User.create!(:name => "Example User",
                       :email => "example@uconnFace.com",
                       :password => "123123",
                       :password_confirmation => "123123")
          99.times do |n|
            name = Faker::Name.name
            email ="example-#{n+1}@uconnFace.com"
            password = "password"
            User.create!(:name => name,
                         :email => email,
                         :password => password,
                         :password_confirmation => password)
     end
    end
   end