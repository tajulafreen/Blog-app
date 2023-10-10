require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index', type: :request do
    let!(:user) do
      User.create(
        name: 'test user',
        photo: 'https://example.com/photos/0X8086XX09',
        bio: 'test_bio',
        posts_counter: 1
      )
    end

    before(:example) { get "/users/#{user.id}/posts" }

    it 'displays a list of posts' do
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      expect(response).to render_template('index')
    end

    it 'includes correct placeholder text in the response body' do
      expect(response.body).to include('test user')
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
    
    let!(:post) do
      Post.create(
        author: user,
        title: 'Hello',
        text: 'This is my first post',
        comments_counter: 1,
        likes_counter: 1
      )
    end

    before(:example) do
      get "/users/#{user.id}/posts/#{post.id}"
    end

    it 'displays the post details for a given post' do
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      expect(response).to render_template('show')
    end

    it 'includes correct placeholder text in the response body' do
      expect(response.body).to include(post.text)
    end
  end
end
