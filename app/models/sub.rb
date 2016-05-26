class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true
  validates :title, uniqueness: true

  belongs_to :moderator,
    class_name: "User",
    foreign_key: :moderator_id

  has_many :post_subs

  has_many :posts,
    through: :post_subs,
    source: :post

  def sort_posts_by_score
    fail
    
    hash = Hash.new() { |h,k| h[k] = Array.new }
    self.posts.each do |post|
      hash[post.score] << post
    end
    hash.sort_by { |k,v| k}.reverse
  end
end
