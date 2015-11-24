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

  has_many :comments
end
