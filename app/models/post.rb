class Post < ApplicationRecord
  paginates_per 25
  belongs_to :user
  belongs_to :tag
  has_many :comments
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  validates :points2view, presence: true, numericality: true
end
