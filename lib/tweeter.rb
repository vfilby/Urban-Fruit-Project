module Tweeter
  class TimeLine  
    def self.tweet message
      Delayed::Job.enqueue Tweeter::TwitterJob.new( message )
    end
  end

  class TwitterJob < Struct.new(:message)
    def perform
      Twitter.update message
    end
  end
end




