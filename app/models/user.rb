class User < ApplicationRecord
  has_many :friends
  has_many :userdata
  validates :first_name, :last_name, :website, presence: true
  validates :website, url: true, :allow_blank => true, :allow_nil => true
end
