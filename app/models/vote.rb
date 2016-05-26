class Vote < ActiveRecord::Base
  validates :
  belongs_to :votable, polymorphic: true
end
