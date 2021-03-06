class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable 
  has_many :songs

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
end
