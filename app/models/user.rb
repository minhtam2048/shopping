class User < ApplicationRecord
  
  has_many :items
  has_many :reviews
  has_many :orders, dependent: :destroy

  has_many :conversations, :foreign_key => :sender_id
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  def current_user?(user)
     user == self
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
