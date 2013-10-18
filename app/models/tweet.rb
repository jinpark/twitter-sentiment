
class Tweet < ActiveRecord::Base
  # after_save :delete_after_5_min
  
  
  def self.get_tweets(keyword)
    Sentimental.load_defaults
    analyzer = Sentimental.new

    TweetStream.configure do |config|
      config.consumer_key       = ENV["TWITTER_CONSUMER"]
      config.consumer_secret    = ENV["TWITTER_CONSUMER_SECRET"]
      config.oauth_token        = ENV["TWITTER_OAUTH"]
      config.oauth_token_secret = ENV["TWITTER_OAUTH_SECRET"]
      config.auth_method        = :oauth
    end
    
    TweetStream::Client.new.track(keyword) do |status|
      if !status.text.include?("RT")
        Tweet.create(content: status.text, sentiment: "#{analyzer.get_score(status.text)}", keyword: keyword)
      end
    end
    handle_asynchronously :get_tweets
  end
  
  # def delete_after_5_min
  #   sleep 5*60
  #   self.destroy
  # end
  
  
end
