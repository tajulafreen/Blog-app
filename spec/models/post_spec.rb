require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(name: 'John Doe', posts_counter: 0)
    post = user.posts.build(title: 'Valid Post', comments_counter: 0, likes_counter: 0)
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    user = User.create(name: 'Alice', posts_counter: 0)
    post = user.posts.build(comments_counter: 0, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'is not valid with a long title' do
    user = User.create(name: 'Bob', posts_counter: 0)
    post = user.posts.build(title: 'A' * 251, comments_counter: 0, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'is not valid with a negative comments_counter' do
    user = User.create(name: 'Eve', posts_counter: 0)
    post = user.posts.build(title: 'Negative Comments', comments_counter: -1, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'increments the user posts_counter after creation' do
    user = User.create(name: 'Charlie', posts_counter: 0)
    user.posts.create(title: 'New Post', comments_counter: 0, likes_counter: 0)
    user.reload
    expect(user.posts_counter).to eq(1)
  end

  it 'returns recent comments' do
    user = User.create(name: 'David', posts_counter: 0)
    post = user.posts.create(title: 'Recent Comments Test', comments_counter: 0, likes_counter: 0)

  
    comment1 = post.comments.create(user_id: user.id, text: 'Comment 1')
    comment2 = post.comments.create(user_id: user.id, text: 'Comment 2')

    recent_comments = post.recent_comments

    expect(recent_comments).to eq([comment2, comment1]) 
  end
end