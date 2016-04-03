# class DigestEmailWorker
#   include Sidekiq::Worker
#   include Sidetiq::Schedulable
#   sidekiq_options :queue => :mailer

#   recurrence { daily.hour_of_day(6) }

#   def perform
#     User.find_each do |user|
#       DigestMailer.daily_email(user).deliver_now
#     end
#   end
# end
