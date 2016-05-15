#Public service object for email notification
#
#Examples
# PersonStatusNotifier.new.notify_person_creation(Person)
# #=> true
# PersonStatusNotifier.new.notify_person_deletion(Person)
# #=> true
class PersonStatusNotifier

  #Public constructor of class
  #
  #Examples
  #
  # PersonStatusNotifier.new
  # #=> #<PersonStatusNotifier:0x00000004554b60>
  #
  #Returns PersonStatusNotifier object
  def initialize
    @people_ids = Person.pluck(:id)
  end

  #Public enqueues a job for each Person of the system excluding the new one for email sending
  #
  #new_person_id - id of created person
  #
  #Examples
  #
  # notify_person_creation(1)
  # #=> true
  #
  #Returns TrueClass
  def notify_person_creation(new_person_id)
    @people_ids.each do |person_id|
      if person_id != new_person_id
        Resque.enqueue(PersonMailerJob, person_id, new_person_id, :new_person_email)
      end
    end
    true
  end

  #Public enqueues a job for each Person of the system to notify a person deletion
  #
  #deleted_person_id - id of deleted person
  #
  #Examples
  #
  # notify_person_deletion(1)
  # #=> true
  #
  #Returns TrueClass
  def notify_person_deletion(deleted_person_id)
    @people_ids.each do |person_id|
      Resque.enqueue(PersonMailerJob, person_id, deleted_person_id, :deleted_person_email)
    end
    true
  end

end