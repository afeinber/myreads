class Book < ActiveRecord::Base
  has_many :comments
  has_many :contributions
  has_many :authors, through: :contributions

  validates :title, :asin, presence: true

  def self.top_ten
    self.all.to_a.sort! { |a,b| a.comments.count <=> b.comments.count}[0..9]
  end

end
