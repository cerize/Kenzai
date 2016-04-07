class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :sprint

  validates :description, presence: true
end
