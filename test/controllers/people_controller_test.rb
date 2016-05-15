require 'test_helper'

describe PeopleController do
  setup { @person = create(:person) }

  test 'gets index' do
    get :index
    assert_response :success
    assert_not_nil(:people)
  end

  test 'gets new' do
    get :new
    assert_response :success
  end

  test 'creates person' do
    assert_difference('Person.count', 1) { post :create, person: attributes_for(:person) }
    assert_redirected_to person_path(assigns(:person))
    assert_queued(PersonMailerJob, [@person.id, assigns(:person).id, 'new_person_email'])
  end

  test 'shows person' do
    get :show, id: @person
    assert_response :success
  end

  test 'gets edit' do
    get :edit, id: @person
    assert_response :success
  end

  test 'updates person' do
    attributes = attributes_for(:person)
    put :update, id: @person, person: attributes
    assert_redirected_to person_path(assigns(:person))
    updated_attributes = assigns(:person).attributes.delete_if { |k, _| %w(id created_at updated_at).include?(k) }
    updated_attributes['gender'] = Person::GENDERS.invert[updated_attributes['gender']]
    assert_equal(updated_attributes.symbolize_keys, attributes)
  end

  test 'destroys person' do
    other_person = create(:person)
    assert_difference('Person.count', -1) { delete :destroy, id: @person }
    assert_queued(PersonMailerJob, [other_person.id, @person.id, 'deleted_person_email'])
    assert_redirected_to people_path
  end
end
