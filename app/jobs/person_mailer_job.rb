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
  def self.perform(recipient_ids, options, method)
    recipients = Person.find(recipient_ids)
    send_to_recipients(recipients,options,method)
  end

  private

  #Internal send an specific email to a list of recipients
  #
  #recipients - People whose wil receive the mail
  #user - Person that receives the action
  #method - defines which method of the mailer is called
  #
  #Examples
  # send_to_recipients([<Person>,<Person>...,<Person>] <Person> :new_person_email)
  # #=> [<Person>,<Person>...,<Person>]
  # send_to_recipients([<Person>,<Person>...,<Person>] <Person> :deleted_person_email)
  # #=> [<Person>,<Person>...,<Person>]
  #
  #Returns List of Person objects
  def self.send_to_recipients(recipients,options,method)
    recipients.each do |recipient|
      PersonMailer.send(method,recipient,options).deliver
    end
  end

end