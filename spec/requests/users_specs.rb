require 'rails_helper'

RSpec.describe 'UsersControllers', type: :request do
  describe 'GET /index' do
    before(:example) { get users_path }

    it 'displays a list of users' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      expect(response).to render_template('index')
    end

    it 'includes correct placeholder text in the response body' do
      expect(response.body).to include('User')
    end
  end

  describe 'GET /show' do
    let(:user) { User.create(name: 'John') }

    before(:example) { get user_path(user) }

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      expect(response.body).to include('User')
    end
  end
end
