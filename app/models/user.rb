class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role
  has_many :projects
  belongs_to :company ,optional:true
  belongs_to :designation , optional: true
  belongs_to :department,   optional: true
  has_one :email_hierarchy
  has_many :workreports
  has_many :clients
  has_one_attached :image
  has_one_attached :avatar




  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :password_no_spaces
  validates :designation, presence: true, unless: -> { role_id == 2 }
  validates :department, presence: true, unless: -> { role_id == 2 }


def password_no_spaces
  if password&.include?(' ')
    errors.add(:password, "can't contain spaces")
  end
end


  def active_for_authentication?
    super && isactive?
  end

  def soft_delete
    update_attribute(:isactive, false)
  end

  before_save do |user|
    user.email = email.downcase
  end

  private

  def super_admin?
    role_id == 1
  end


  def unique_super_admin_user
    if User.exists?(role_id: 1)
      errors.add(:role_id, "Only one user is allowed with role_id == 1")
    end
  end
end
