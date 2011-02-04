

namespace :db do
           desc "Fill dabase with sample data"
          task :populate => :environment do
          Rake::Task['db:reset'].invoke
#          populate_users
#          populate_microposts
#          populate_follow
   end
 end


def populate_users
    admin = User.create!(:name => "Maximum Admin",
                       :email => "example@uconnFace.com",
                       :password => "123123",
                       :password_confirmation => "123123")
                       admin.toggle!(:admin)
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


def populate_microposts
    User.all(:limit => 6).each do |user|
               50.times do 
                   user.microposts.create!(:content =>
                              Faker::Lorem.sentence(6))
               end 
           end
end 

def populate_follow
    users = User.all
    user  = users.first
    following = users[1..50]
    followers = users[3..40]
    following.each { |followed| user.follow!(followed) }
    followers.each { |follower| follower.follow!(user) }
end 
