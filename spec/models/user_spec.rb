require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name and a valid posts_counter' do
    user = User.new(name: 'John', posts_counter: 5)
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = User.new(posts_counter: 5)
    expect(user).not_to be_valid
  end

  it 'is invalid with a negative posts_counter' do
    user = User.new(name: 'John', posts_counter: -1)
    expect(user).not_to be_valid
  end

  it 'returns recent posts' do
    user = User.create(name: 'Emma', posts_counter: 0)

    post1 = user.posts.create(title: 'Post 1', comments_counter: 0, likes_counter: 0)
    post2 = user.posts.create(title: 'Post 2', comments_counter: 0, likes_counter: 0)

    recent_posts = user.recent_posts

    expect(recent_posts).to eq([post2, post1])
  end
end
