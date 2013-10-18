require 'tweetstream'
require 'sentimental'

Sentimental.load_defaults
analyzer = Sentimental.new

TweetStream.configure do |config|
  config.consumer_key       = '0EltitEhuIIgMYoti5Cf5w'
  config.consumer_secret    = '7BW2F4xWpPTlMivXFN1JE5yXNiWKPyEtxoTQmfaocn8'
  config.oauth_token        = '46588500-hoSR7a2h5ww11ggcBXOf0ZB9J5BKnqOwRuXqAEmI'
  config.oauth_token_secret = 'VRz5fGrnAZC0cnysp4yw3ItC9EBUNsMpsHtugxlWU'
  config.auth_method        = :oauth
end

# This will pull a sample of all tweets based on
# your Twitter account's Streaming API role.
# TweetStream::Client.new.sample do |status|
#   # The status object is a special Hash with
#   # method access to its keys.
#   puts "#{status.text}"
# end

def analysis(keyword)
  TweetStream::Client.new.track(keyword) do |status|
    puts "#{status.text} #{analyzer.get_score(status.text)}"
  end
end

# analysis('coke')

TweetStream::Client.new.track('coke') do |status|
  puts "#{status.text} #{analyzer.get_score(status.text)}"
end