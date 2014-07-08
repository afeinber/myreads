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

  def self.from_amazon_element(element)
    as_a_book = Book.new(
      photo: element.get_hash('MediumImage')["URL"],
      title: element.get('ItemAttributes/Title'),
      published_on: element.get('ItemAttributes/PublicationDate'),
      asin: element.get('ASIN')
    )
    authors = element.get_element('ItemAttributes').get_array('Author')
    authors.each do |author|
      as_a_book.authors.new(name:author)
    end
    as_a_book
  end

  def self.search(search, search_method)
    if search
      books = []
      res = Amazon::Ecs.item_search('', {:response_group => 'Medium', search_method.downcase.to_sym => search})
      res.items.each do |item|
        books << Book.from_amazon_element(item)
      end
      books
    else
      self.top_ten
    end
  end

end
