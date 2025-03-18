class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :phone_number, presence: true, uniqueness: true, format: { with: /\A\d{10,15}\z/, message: "must be a valid phone number" }

  has_many :messages
  has_many :casinogames
  #has_many :games, foreign_key: 'user_id'
  
  def admin?
      role == 'admin'
  end
end
