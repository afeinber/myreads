class Follow < ActiveRecord::Base
  belongs_to :user
  belongs_to :followee, :class_name => "User", :foreign_key => "followee_id"

  validates! :user_id, uniqueness: {scope: :followee_id}
  validates! :user_id, exclusion: { in: [:followee_id] }

  before_create(:delete_requests)


  def delete_requests
    rqst = self.user.inverse_requests.find_by(user: self.followee)
    rqst.destroy if rqst.present?
  end
end
