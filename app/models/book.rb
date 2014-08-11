class Book < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :contributions, dependent: :destroy
  has_many :authors, through: :contributions

  validates :title, :asin, presence: true

  NO_IMAGE = "http://g-ecx.images-amazon.com/images/G/01/x-site/icons/no-img-lg._V192198896_BO1,204,203,200_.gif"

  def self.top_ten(user)
    unless user.present?
      #gets most commented books for the homepage
      self.all.to_a.sort! { |a,b| a.comments.size <=> b.comments.size}.reverse[0..9]
    else
      #gets the most recently commented books by the people that the user is following
      comments = []
      user.followees.each { |user| comments += user.comments}
      comments.to_a.sort_by(&:created_at).reverse.map(&:book).uniq
    end
  end

  def most_recent_comment(user)
    unless user.present?
      self.comments.order(:created_at).last
    else
      comments = []
      user.followees.each { |user| comments += user.comments}
      comments.select { |comment| comment.book == self }.sort_by(&:created_at).first
    end
  end

  def self.from_amazon_element(element)

    as_a_book = Book.new(
      photo: element.get_hash('MediumImage') ? element.get_hash('MediumImage')['URL'] : NO_IMAGE,
      title: element.get('ItemAttributes/Title'),
      published_on: element.get('ItemAttributes/PublicationDate'),
      asin: element.get('ASIN'),
      large_photo: element.get_hash('LargeImage') ? element.get_hash('LargeImage')['URL'] : NO_IMAGE
    )

    authors = element.get_element('ItemAttributes').get_array('Author')
    authors.each do |author|
      as_a_book.authors. << Author.get_author(author)
    end

    as_a_book
  end

  def self.search(search, search_method, user)
    if search

      books = []
      res = Amazon::Ecs.item_search('', {:response_group => 'Medium', search_method.downcase.to_sym => search})
      res.items.each do |item|

        books << Book.from_amazon_element(item)
      end
      books
    else
      self.top_ten(user)
    end
  end

  def self.get_book(asin)

    book = Book.from_amazon_element(
      Amazon::Ecs.item_lookup(asin,
      {:response_group => 'Medium'}).items.first) unless
        (book = Book.find_by(asin: asin)).present?

    book
  end

  #This almost never works because Amazon.
  def self.top_sellers
    books = []
    res = Amazon::Ecs.browse_node_lookup('1000', {:response_group => 'TopSellers'})
    doc = Nokogiri::XML(res.doc.children.to_s)
    asins = doc.xpath("//ASIN")
    asins = asins.map(&:text)[0..9]
    asins.each do |asin|
      books << Book.from_amazon_element(Amazon::Ecs.item_lookup(asin, :response_group => "Medium").items.first)
    end
    books
  end

  def to_param
    self.asin
  end

end
