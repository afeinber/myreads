class Author < ActiveRecord::Base
  has_many :contributions
  has_many :books, through: :contributions
end
