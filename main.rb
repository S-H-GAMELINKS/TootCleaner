require 'bundler/setup'
Bundler.require(:default)

require 'mastodon'
require 'dotenv'
require 'open-uri'
require 'clockwork'

include Clockwork

Dotenv.load

client = Mastodon::REST::Client.new(base_url: ENV["URL"], bearer_token: ENV["TOKEN"])

id = client.verify_credentials.id
5.times do 
    client.statuses(id).each do |status|
        client.destroy_status(status.id)
    end
end

# Remove Follow
#client.following(id).each do |follow|
#    client.unfollow(follow.id)
#end

# Remove Follower
#client.followers(id).each do |follower|
#    client.block(follower.id)
#end