module Tweeter
  class TimeLine  
    def self.tweet message, params = {}
      
      # this is overkill right now but
      # I am hoping to do smart things with 
      # users and urls during the replacement
      params.each do |token,replacement|
        message[ ":"+token.to_s] = replacement
      end
      
      Delayed::Job.enqueue Tweeter::TwitterJob.new( message )
      
    rescue
      #this method should never fail.
      #log maybe, but fail... never!
    end
  end

  class TwitterJob < Struct.new(:message)
    def perform
      Twitter.update message
    end
  end
end




