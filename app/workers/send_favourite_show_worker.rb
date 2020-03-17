class SendFavouriteShowWorker

  include Sidekiq::Worker
  #sidekiq_options retry: false


  def perform(email,show_id)
    ReminderMailer.show_reminder(email,show_id).deliver_now
  end

end
