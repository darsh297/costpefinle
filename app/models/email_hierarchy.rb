class EmailHierarchy < ApplicationRecord
  has_and_belongs_to_many :user
  belongs_to :to_user, class_name: 'User', foreign_key: 'to_user_id', optional: true
  belongs_to :cc_user, class_name: 'User', foreign_key: 'cc_user_id', optional: true
end
