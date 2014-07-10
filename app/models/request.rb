class Request < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipient, :class_name => "User", :foreign_key => "recipient_id"

  validates! :user_id, uniqueness: {scope: :recipient_id}
  validates! :user_id, exclusion: { in: [:recipient_id] }
  #validates! :user_id, exclusion: { in: self.recipient.follows.map(&:followee_id) }

end
