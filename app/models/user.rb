class User < ApplicationRecord
  has_one :ur_store
  has_many :items , through: :store
  has_many :reviews
  has_many :orders, dependent: :destroy

  has_many :conversations, :foreign_key => :sender_id

  has_one_attached :avatar
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
