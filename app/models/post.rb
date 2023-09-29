class Post < ApplicationRecord

  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
  after_create :increment_user_posts_counter

  private

  def increment_user_posts_counter
    author.increment!(:posts_counter)
  end
end
