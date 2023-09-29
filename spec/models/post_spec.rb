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

  it 'returns the 5 most recent comments' do
    user = User.create(name: 'Charlie', posts_counter: 0)
    post = user.posts.create(title: 'Post with Comments')
    post.comments.create(author: user, body: 'Old comment')
    newer_comment1 = post.comments.create(author: user, body: 'Newer comment 1')
    newer_comment2 = post.comments.create(author: user, body: 'Newer comment 2')
    newer_comment3 = post.comments.create(author: user, body: 'Newer comment 3')
    newer_comment4 = post.comments.create(author: user, body: 'Newer comment 4')
    newer_comment5 = post.comments.create(author: user, body: 'Newer comment 5')

    recent_comments = post.recent_comments

    expect(recent_comments).to eq([newer_comment5, newer_comment4, newer_comment3, newer_comment2, newer_comment1])
  end
end
