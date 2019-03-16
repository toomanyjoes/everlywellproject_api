class Friend < ApplicationRecord
  belongs_to :user
  validates :friend_id, presence: true
  validate :non_identity_friendship
  validate :non_duplicate_friendship

  def non_identity_friendship
    if user_id == friend_id
      errors.add(:friend_id, "cannot be friends with yourself")
    end
  end
  def non_duplicate_friendship
    existing = Friend.where(user_id: user_id, friend_id: friend_id)
    unless existing.empty?
      errors.add(:friend_id, "this friendship already exists")
    end
  end
end
