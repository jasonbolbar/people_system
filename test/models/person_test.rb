require 'test_helper'

describe Person do

  setup { @person = build(:person) }

  test 'Common person' do
    assert @person.valid?
  end

  test 'first name blank' do
    cannot_blank_validation(:first_name)
  end

  test 'first name long text' do
    max_characters_validation(:first_name, 75)
  end

  test 'last name blank' do
    cannot_blank_validation(:last_name)
  end

  test 'last name long text' do
    max_characters_validation(:last_name, 75)
  end

  test 'email blank' do
    cannot_blank_validation(:email, 'is invalid')
  end

  test 'email long text' do
    max_characters_validation(:email, 254, 'is invalid')
  end

  test 'not unique email' do
    no_unique_validation(:email)
  end

  test 'invalid email' do
    @person.email = Faker::Internet.email.sub('@', '')
    assert_not @person.valid?
    with_message(:email, 'is invalid')
  end

  test 'job long text' do
    max_characters_validation(:job, 75)
  end

  test 'invalid gender' do
    @person.gender = 'unknown'
    assert_not @person.valid?
    with_message(:gender, 'is invalid')
  end

  test 'birth_date blank' do
    cannot_blank_validation(:birth_date)
  end

  test 'birth_date in future date' do
    @person.birth_date = Date.tomorrow
    assert_not @person.valid?
    with_message(:birth_date, 'cannot accept a future date')
  end

  test 'not unique picture' do
    no_unique_validation(:picture)
  end

  test 'invalid url format' do
    @person.picture = Faker::Internet.url
    assert_not @person.valid?
    with_message(:picture, 'is invalid')
  end

  private

  def with_message(key, message)
    assert_equal @person.errors.messages, {key => Array.wrap(message)}
  end

  def cannot_blank_validation(field_name, *other_messages)
    @person.send("#{field_name}=", [nil, ''].sample)
    assert_not @person.valid?
    with_message(field_name.to_sym, ['can\'t be blank'] + other_messages)
  end

  def max_characters_validation(field_name, max_characters, *other_messages)
    @person.send("#{field_name}=", Faker::Lorem.characters(max_characters + 1))
    assert_not @person.valid?
    with_message(field_name.to_sym, ["is too long (maximum is #{max_characters} characters)"] + other_messages)
  end

  def no_unique_validation(field_name)
    persisted_person = create(:person)
    @person.send("#{field_name}=", persisted_person.send(field_name))
    assert_not @person.valid?
    with_message(field_name.to_sym, 'has already been taken')
  end

end
