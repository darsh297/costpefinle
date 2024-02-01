class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


belongs_to :role
belongs_to :company
belongs_to :designation
belongs_to :department


         def soft_delete
          update_attribute(:isactive, false)
        end
end
