class UserdatumSerializer < ActiveModel::Serializer
  attributes :user_id, :data_type, :data
end
