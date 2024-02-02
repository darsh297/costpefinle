class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role
  belongs_to :company ,optional:true
  belongs_to :designation , optional: true
  belongs_to :department,   optional: true


  validate :unique_super_admin_user, if: :super_admin?

  validates :designation, presence: true, unless: -> { role_id == 2 }
  validates :department, presence: true, unless: -> { role_id == 2 }

  def soft_delete
    update_attribute(:isactive, false)
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
