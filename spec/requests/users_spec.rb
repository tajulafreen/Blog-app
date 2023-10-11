require 'rails_helper'

RSpec.describe 'users', type: :request do
  let!(:user) do
    User.create(
      name: 'test user1',
      photo: 'https://example.com/default-photo.jpg',
      bio: 'test_bio',
      posts_counter: 2
    )
  end
  describe 'GET /index', type: :request do
    before(:example) { get '/users' }

    it 'displays a list of users' do
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      expect(response).to render_template('index')
    end

    it 'includes correct placeholder text in the response body' do
      expect(response.body).to include('Number Of posts 2')
    end
  end
  describe 'GET /show', type: :request do
    let!(:user) do
      User.create(
        name: 'test user',
        photo: 'https://example.com/photos/0X8086XX09',
        bio: 'test_bio',
        posts_counter: 1
      )
    end
    before(:example) { get "/users/#{user.id}" }

    it 'displays the user details for a given user' do
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      expect(response).to render_template('show')
    end

    it 'includes correct placeholder text in the response body' do
      expect(response.body).to include('test user')
    end
  end
end
