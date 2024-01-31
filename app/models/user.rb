class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


belongs_to :role
belongs_to :company
belongs_to :designation
belongs_to :department


         def soft_delete

        end
end
