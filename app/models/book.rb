module Amazon
  class Element
    def to_book
      as_a_book = Book.new(
        photo: self.get_hash('MediumImage')["URL"],
        title: self.get('ItemAttributes/Title'),
        published_on: self.get('ItemAttributes/PublicationDate'),
        asin: self.get('ASIN')
      )
      authors = self.get_element('ItemAttributes').get_array('Author')
      authors.each do |author|
        as_a_book.authors.new(name:author)
      end
      as_a_book
    end
  end
end



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

  def self.search(search)
    if search
      books = []
      res = Amazon::Ecs.item_search(search, {:response_group => 'Medium'})
      res.items.each do |item|
        books << item.to_book
      end
      books
    else
      self.top_ten
    end
  end

end
