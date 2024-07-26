class ContactMailer < ApplicationMailer
  default from: 'no-reply@winnipegwonders.com'

  def contact_email(name, email, message)
    @name = name
    @message = message
    @user_email = email
    mail(to: 'support@winnipegwonders.com', subject: 'New Contact Message')
  end
end
