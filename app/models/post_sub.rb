class PostSub < ActiveRecord::Base
  validates :sub_id, :post, presence: true

  belongs_to :sub
  belongs_to :post, inverse_of: :post_subs

end
