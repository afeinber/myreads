class Follow < ActiveRecord::Base
  belongs_to :user
  belongs_to :followee, :class_name => "User", :foreign_key => "followee_id"

  validates! :user_id, uniqueness: {scope: :followee_id}
  validates! :user_id, exclusion: { in: [:followee_id] }
end
