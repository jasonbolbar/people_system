require 'test_helper'

describe PersonMailerJob do

  test 'new person email' do
    people = 5.times.map{ create(:person) }
    user = create(:person)
    PersonMailerJob.perform(people.map(&:id), {'new_person_id' => user.id}, :new_person_email)
    mail = ActionMailer::Base.deliveries.last(5)
    assert_equal people.map(&:email), mail.map{|m| m[:to].value}
  end

  test 'deleted person email' do
    people = 5.times.map{ create(:person) }
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    PersonMailerJob.perform(people.map(&:id), {'first_name' => first_name, 'last_name'=> last_name}, :deleted_person_email)
    mail = ActionMailer::Base.deliveries.last(5)
    assert_equal people.map(&:email), mail.map{|m| m.to.first}
    mail.each do |mail|
      assert_match Regexp.new("#{first_name} #{last_name} has left the application"), mail.body.to_s
    end
  end

end