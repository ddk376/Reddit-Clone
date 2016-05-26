class Comment < ActiveRecord::Base
  validates :content, :author_id, :post_id, presence: true

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id

  belongs_to :post

  belongs_to :parent_comment,
    class_name: "Comment",
    foreign_key: :parent_comment_id

  has_many :child_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id
  has_many :votes, as: :votable

  def num_of_upvotes
    self.votes.where("value = 1").length
  end

  def num_of_downvotes
    self.votes.length - self.num_of_upvotes
  end
end
