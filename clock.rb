require File.expand_path('../realtSite.rb', __FILE__)
require 'clockwork'

include Clockwork


every(2.minutes, 'Queueing interval job') { Delayed::Job.enqueue IntervalJob.new  }