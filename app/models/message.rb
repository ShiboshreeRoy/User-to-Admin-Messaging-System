class Message < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :title, presence: true
  validates :amount, presence: true
  
  
  

end
