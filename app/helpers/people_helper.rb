module PeopleHelper

  def age(birth_date)
    Date.today.year - birth_date.year
  end

  def human_gender(gender)
    Person::GENDERS.invert[gender].to_s.titleize
  end
end