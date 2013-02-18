require File.expand_path('../realtSite.rb', __FILE__)
require 'clockwork'

include Clockwork


every(1.day, 'Queueing scheduled job', :at => '15:00') { Delayed::Job.enqueue ScheduledJob.new }