class PersonMailer < ApplicationMailer

  #Public Creates an email that notifies when a user is added to the aplication
  #
  #recipient - Person who will receive the email
  #user - Person that will deleted from the app
  #
  #Examples
  # PersonMailer.new_person_email
  # #=> Mail::Message object
  #
  #Returns Mail::Message object
  def new_person_email(recipient,user)
    @user = user
    @recipient = recipient
    mail(to: @recipient.email, subject: 'People App - New person added')
  end
  #Public Creates an email that notifies when a user is added to the aplication
  #
  #recipient - Person who will receive the email
  #user - Person that will deleted from the app
  #
  #Examples
  # PersonMailer.new_person_email
  # #=> Mail::Message object
  #
  #Returns Mail::Message object
  def deleted_person_email(recipient,user)
    @user = user
    @recipient = recipient
    mail(to: @recipient.email, subject: 'People App - Person deleted')
  end

end
