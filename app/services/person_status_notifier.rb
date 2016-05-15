#Public service object for email notification
#
#Examples
# PersonStatusNotifier.new.notify_person_creation(Person)
# #=> true
# PersonStatusNotifier.new.notify_person_deletion(Person)
# #=> true
class PersonStatusNotifier

  def initialize
    @people_ids = Person.pluck(:id)
  end

  def notify_person_creation(new_person_id)
    @people_ids.each do |person_id|
      if person_id != new_person_id
        Resque.enqueue(PersonMailerJob, person_id, new_person_id, :new_person_email)
      end
    end
    true
  end

  def notify_person_deletion(deleted_person_id)
    @people_ids.each do |person_id|
      Resque.enqueue(PersonMailerJob, person_id, deleted_person_id, :deleted_person_email)
    end
    true
  end

end