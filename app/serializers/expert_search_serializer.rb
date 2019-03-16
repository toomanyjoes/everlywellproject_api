class ExpertSearchSerializer < ActiveModel::Serializer
  attributes :terms, :result, :friend_id
end
