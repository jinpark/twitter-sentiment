class TweetsController < ApplicationController
  include ActionController::Live
  
  def index
    @tweets = Tweet.all
  end
  
  def events
    response.headers["Content-Type"] = "text/event-stream"
    start = Time.zone.now
    10.times do 
      Tweet.uncached do
        Tweet.where('created_at > ?', start).each do |tweet|
          response.stream.write("data: #{tweet.to_json}\n\n")
          start = tweet.created_at
        end
      end
      sleep 1
    end
  rescue IOError
    logger.info "Stream closed"
  ensure
    response.stream.close
    
  end
  
end
