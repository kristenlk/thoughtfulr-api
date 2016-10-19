task :send_messages => :environment do
  Delayed::Job.enqueue(SendMessageJob.new)
end
