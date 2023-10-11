require 'rails_helper'

RSpec.describe 'user show view page', type: :system do
  let!(:user1) do
    User.create(
      name: 'test user1',
      photo: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrkfBY9UTdiEHSYCSo7iuM4k1Eyv-u9YwGqQ&usqp=CAU',
      bio: 'test_bio1',
      posts_counter: 1
    )
  end

  let!(:posts) do
    [
      Post.create(author: user1, title: 'Post 1', text: 'Post 1 content', comments_counter: 1, likes_counter: 1),
      Post.create(author: user1, title: 'Post 2', text: 'Post 2 content', comments_counter: 2, likes_counter: 2),
      Post.create(author: user1, title: 'Post 3', text: 'Post 3 content', comments_counter: 3, likes_counter: 3)
    ]
  end

  describe 'show user and post details' do
    before(:example) do
      visit user_path(user1)
    end

    it 'displays user information' do
      expect(page).to have_content(user1.name)
      expect(page).to have_content(user1.posts_counter)
      expect(page).to have_content(user1.bio)
      expect(page).to have_selector("img[src='#{user1.photo}']")
    end

    it 'displays user\'s first 3 posts' do
      posts.take(3).each do |post|
        expect(page).to have_content(post.title)
        expect(page).to have_content(post.text)
      end
    end

    it 'go to post show page when clicking a post' do
      user_links = all("a[href='#{user_post_path(user1, posts.first)}']")
      user_links.first.click
      expect(page).to have_current_path(user_post_path(user1, posts.first))
    end

    it 'displays a button to view all of a user\'s posts' do
      visit user_path(user1)
      expect(page).to have_link('View All Posts', href: user_posts_path(user1))
    end

    it 'redirects to user\'s posts index page when clicking to View All Posts' do
      click_link 'View All Posts'
      expect(page).to have_current_path(user_posts_path(user1))
    end
  end
end
