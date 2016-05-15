class PersonMailer < ApplicationMailer

  def new_person_email(recipient,user)
    @user = user
    @recipient = recipient
    mail(to: @recipient.email, subject: 'People App - New person added')
  end

  def deleted_person_email(recipient,user)
    @user = user
    @recipient = recipient
    mail(to: @recipient.email, subject: 'People App - Person deleted')
  end

end
