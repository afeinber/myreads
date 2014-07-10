class Author < ActiveRecord::Base
  has_many :contributions, dependent: :destroy
  has_many :books, through: :contributions

  validates! :name, uniqueness: true

  def self.get_author(name)
    self.find_by(name: name) || self.new(name: name)
  end
end
