class SendFavouriteShowWorker

  include Sidekiq::Worker
  #sidekiq_options retry: false


  def perform(email,show_id)
    p "============================="
    p  show_id.inspect
    p "============================="
    ReminderMailer.show_reminder(email,show_id).deliver_now
  end

end
