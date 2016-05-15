module PeopleHelper

  #Public calculates the age of a person according with its birth date
  #
  #birth_date - birth date of a person
  #
  #Examples
  #
  # age('1/4/2002')
  # #=> 14
  #Returns Integer that represents the age of the person
  def age(birth_date)
    Date.today.year - birth_date.year
  end

  #Public returns the gender of a person according with the numerical value
  #
  #gender - numerical value
  #
  #Examples
  #
  # human_gender(1)
  # #=> 'Male'
  #
  # human_gender(2)
  # #=> 'Female'
  #Returns String with the gender of the person
  def human_gender(gender)
    Person::GENDERS.invert[gender].to_s.titleize
  end
end