require 'test_helper'

describe PeopleController do
  let(:person) { create(:person) }

  it 'gets index' do
    get :index
    value(response).must_be :success?
    value(assigns(:people)).wont_be :nil?
  end

  it 'gets new' do
    get :new
    value(response).must_be :success?
  end

  it 'creates person' do
    expect {
      post :create, person: attributes_for(:person)
    }.must_change 'Person.count'

    must_redirect_to person_path(assigns(:person))
  end

  it 'shows person' do
    get :show, id: person
    value(response).must_be :success?
  end

  it 'gets edit' do
    get :edit, id: person
    value(response).must_be :success?
  end

  it 'updates person' do
    put :update, id: person, person: attributes_for(:person)
    must_redirect_to person_path(assigns(:person))
  end

  it 'destroys person' do
    expect {
      delete :destroy, id: person
    }.must_change 'Person.count', -1

    must_redirect_to people_path
  end
end
