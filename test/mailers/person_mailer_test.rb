require 'test_helper'

describe PersonMailer do

  setup do
    @recipient = create(:person)
    @user = create(:person)
  end

  test 'new person mail' do
    body = PersonMailer.new_person_email(@recipient,@user).body.to_s
    assert_match Regexp.new("Hello #{@recipient.first_name} #{@recipient.last_name}"), body
    assert_match Regexp.new("#{@user.first_name} #{@user.last_name} has joined the application"), body
  end

  test 'deleted person mail' do
    body = PersonMailer.deleted_person_email(@recipient,@user).body.to_s
    assert_match Regexp.new("Hello #{@recipient.first_name} #{@recipient.last_name}"), body
    assert_match Regexp.new("#{@user.first_name} #{@user.last_name} has left the application"), body
  end

end