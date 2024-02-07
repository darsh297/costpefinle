class Workreport < ApplicationRecord
  belongs_to :project
  belongs_to :user

    validates :user_id, presence: true, unless: :user_with_role_six?

    private

    def user_with_role_six?
      user&.role_id == 6
    end
end

