class Workreport < ApplicationRecord
  has_many :projects
  belongs_to :user

  validates :user_id, presence: true, unless: :user_with_role_six?
  validate :one_report_per_user, on: :create
  validates :date, presence: true

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  def active_users
    where(isactive: true)
  end

  private

  def user_with_role_six?
    user&.role.role_name == "Employee"
  end

  def one_report_per_user
    if user_id.present? && date.present?
      existing_report = Workreport.find_by(user_id: user_id, date: date)
      errors.add(:base, "A report for this user on this date already exists") if existing_report.present?
    end
  end

  def slug_candidates
    if user_id.present?
      [:name, [:name, :user_id_true]]
    else
      :name
    end
  end

  def user_id_true
    "user=true"
  end
end
