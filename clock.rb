require File.expand_path('../realtSite.rb', __FILE__)
require 'clockwork'

include Clockwork


every(1.day, 'Queueing scheduled job', :at => '14:17') { Delayed::Job.enqueue ScheduledJob.new }