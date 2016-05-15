class Person < ActiveRecord::Base

  # Public: Hash with valid genders and its numerical value
  GENDERS = {male: 1, female: 2}

  validates :first_name, presence: true, length: {maximum: 75}
  validates :last_name, presence: true, length: {maximum: 75}
  validates :email, presence: true, length: {maximum: 254}, uniqueness: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :job, length: {maximum: 75}
  validates :gender, inclusion: {in: [1, 2], message: 'gender is invalid'}
  validates :birth_date, presence: true
  validate :not_future_birth_date
  validates :picture, uniqueness: {allow_blank: true}, format:
      {with: /\A(http|https):\/{2}[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?(\/.*\.(png|jpg|gif|bmp))\z/,
       allow_blank: true
      }

  #Public: Overrides the setter for gender attribute
  #
  #gender - String with the key of gender
  #
  #Examples
  #
  # self.gender = 'male'
  # # => 'male'
  #
  #Returns the value provided as parameter
  def gender=(gender)
    super(GENDERS[gender.to_sym] || 0)
  end

  private

  #Internal: Add a key/value pair on the errors hash in if the birth date is in the future
  #
  #
  #Examples
  #
  # not_future_birth_date
  # # => ['cannot accept a future date'] if the condition is accomplished
  #
  #Returns an array with the error if condition is accomplished
  def not_future_birth_date
    errors.add(:birth_date, 'cannot accept a future date') if birth_date.present? && birth_date > Date.today
  end

end
