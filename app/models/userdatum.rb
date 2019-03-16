class Userdatum < ApplicationRecord
  belongs_to :user
  validates :user_id, :data_type, :data, presence: true
end
