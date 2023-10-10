require 'rails_helper'

RSpec.describe 'user index view page', type: :system do
  let!(:user1) do
    User.create(
      name: 'test user1',
      photo: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrkfBY9UTdiEHSYCSo7iuM4k1Eyv-u9YwGqQ&usqp=CAU',
      bio: 'test_bio1',
      posts_counter: 1
    )
  end

  let!(:user2) do
    User.create(
      name: 'test user2',
      photo: 'https://lumiere-a.akamaihd.net/v1/images/ct_cinderella_upcportalreskin_20694_f7c876a1.jpeg?region=0,0,330,330',
      bio: 'test_bio2',
      posts_counter: 2
    )
  end

  let!(:user3) do
    User.create(
      name: 'test user3',
      photo: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrkfBY9UTdiEHSYCSo7iuM4k1Eyv-u9YwGqQ&usqp=CAU',
      bio: 'test_bio3',
      posts_counter: 0
    )
  end

  describe 'user content' do
    before(:example) do
      visit users_path
    end

    it 'can see all users names' do
      expect(page).to have_content(user1.name)
      expect(page).to have_content(user2.name)
      expect(page).to have_content(user3.name)
    end

    it ' can see profile picture' do
      expect(page).to have_selector('img#user-image[src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrkfBY9UTdiEHSYCSo7iuM4k1Eyv-u9YwGqQ&usqp=CAU"]')
      expect(page).to have_selector('img#user-image[src="https://lumiere-a.akamaihd.net/v1/images/ct_cinderella_upcportalreskin_20694_f7c876a1.jpeg?region=0,0,330,330"]')
      expect(page).to have_selector('img#user-image[src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrkfBY9UTdiEHSYCSo7iuM4k1Eyv-u9YwGqQ&usqp=CAU"]')
    end

    it 'can see posts count' do
      expect(page).to have_content('Number Of posts 1')
      expect(page).to have_content('Number Of posts 2')
      expect(page).to have_content('Number Of posts 0')
    end
  end

  describe 'click on a user' do
    before(:example) do
      visit users_path
    end

    it 'redirects to user show page when clicking on user name' do
      user_link = find("a[href='#{user_path(user1)}']")
      user_link.click
      expect(page).to have_current_path(user_path(user1))
      expect(page).to have_content(user1.name)
      expect(page).to have_content(user1.bio)
    end
  end
end