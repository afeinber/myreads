class Recommendation < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'

  validates! :user, :book, :recipient, presence: true
  validates! :user_id, uniqueness: {scope: [:book_id, :recipient_id] }
end
