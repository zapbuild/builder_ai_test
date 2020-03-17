class ReminderMailer < ApplicationMailer

  default from: 'notifications@example.com'
  layout 'mailer'
  def show_reminder(email,show_id)
    p "=================+++++++++++============"
    p  show_id.inspect
    p "==================++++++++++++==========="
    @show_id = show_id
    mail(to: email, subject: "Show reminder")
  end


end
