class Book < ActiveRecord::Base
  has_many :comments
  has_many :contributions
  has_many :authors, through: :contributions

  validates :title, :asin, presence: true

  def self.top_ten
    self.all.to_a.sort! { |a,b| a.comments.count <=> b.comments.count}.reverse[0..9]
  end

  def most_recent_comment
    self.comments.to_a.sort_by!(&:created_at).last
  end
end
