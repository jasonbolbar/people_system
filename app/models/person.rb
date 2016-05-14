class Person < ActiveRecord::Base

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
  def gender=(gender)
    super(GENDERS[gender.to_sym] || 0)
  end

  private

  def not_future_birth_date
    errors.add(:birth_date, 'cannot accept a future date') if birth_date.present? && birth_date > Date.today
  end

end
