require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(name: 'John Doe', posts_counter: 0)
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(posts_counter: 0)
    expect(user).to_not be_valid
  end

  it 'is not valid with a negative posts_counter' do
    user = User.new(name: 'Alice', posts_counter: -1)
    expect(user).to_not be_valid
  end

  it 'returns the 3 most recent posts' do
    user = User.create(name: 'Bob', posts_counter: 0)
    older_post = user.posts.create(title: 'Old Post', text: 'This is an old post')
    newer_post1 = user.posts.create(title: 'Newer Post 1', text: 'This is a newer post')
    newer_post2 = user.posts.create(title: 'Newer Post 2', text: 'This is another newer post')

    recent_posts = user.recent_posts

    expect(recent_posts).to eq([newer_post2, newer_post1, older_post])
  end
end
