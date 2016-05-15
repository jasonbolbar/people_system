class PersonMailerJob

  #Internal Queue that Resque will use for this job
  @queue = :email_queue

  #Public performs an email delivery according with a method
  #
  #recipient_id - Id on the database for the recipient of the mail
  #user_id - Id of the user that the action is performed
  #method - defines which method of the mailer is called
  #
  #Examples
  # Resque.enqueue(PersonMailerJob, 1, 20, :new_person_email)
  # #=> true
  # Resque.enqueue(PersonMailerJob, 1, 20, :deleted_person_email)
  # #=> true
  #
  #Returns boolean value in case the job is added to Resque
  def self.perform(recipient_id, user_id, method)
    recipient = Person.find(recipient_id)
    user = Person.find(user_id)
    PersonMailer.send(method,recipient,user).deliver
  end

end