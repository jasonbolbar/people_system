class PersonMailer < ApplicationMailer

  #Public Creates an email that notifies when a user is added to the aplication
  #
  #recipient - Person who will receive the email
  #options - options for mail
  #          :new_user_id  - id of created user
  #
  #Examples
  # PersonMailer.new_person_email(<Person>,{'new_user_id' => '1'})
  # #=> Mail::Message object
  #
  #Returns Mail::Message object
  def new_person_email(recipient, options)
    @user = Person.find(options['new_user_id'])
    @recipient = recipient
    mail(to: @recipient.email, subject: 'People App - New person added')
  end

  #Public Creates an email that notifies when a user is added to the application
  #
  #recipient - Person who will receive the email
  #options - options for mail
  #          :first_name  - first name of the person
  #          :last_name  - last name of the person
  #
  #Examples
  # PersonMailer.deleted_person_email(<Person>,{'first_name' => 'Jon', 'last_name' => 'Doe'})
  # #=> Mail::Message object
  #
  #Returns Mail::Message object
  def deleted_person_email(recipient, options)
    @user = Person.new(first_name: options['first_name'], last_name: options['last_name'])
    @recipient = recipient
    mail(to: @recipient.email, subject: 'People App - Person deleted')
  end

end
