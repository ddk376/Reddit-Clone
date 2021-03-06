class Post < ActiveRecord::Base
  validates :title, :author_id, :post_subs, presence: true

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id

  has_many :post_subs,
    inverse_of: :post,
    dependent: :destroy

  has_many :subs,
    through: :post_subs,
    source: :sub

  has_many :comments,
    class_name: "Comment",
    foreign_key: :post_id,
    primary_key: :id

  has_many :votes, as: :votable

  def num_of_upvotes
    self.votes.where("value = 1").length
  end

  def num_of_downvotes
    self.votes.length - self.num_of_upvotes
  end
  def comments_by_parent_id
    hash = Hash.new{|h,k| h[k]= Array.new}
    all_comments = self.comments include: :author
    all_comments.each do |comment|
      hash[comment.parent_comment_id] << comment
    end
    hash
  end

  def score
    self.votes.map{|vote| vote.value }.inject(0){|sum, n| sum + n }
  end
end
