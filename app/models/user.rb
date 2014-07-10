class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :comments, dependent: :destroy
  has_many :books, through: :listed_books
  has_many :listed_books, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :followees, through: :follows
  has_many :requests, dependent: :destroy
  #has_many :recipients, through: :requests
  has_many :inverse_requests, class_name: 'Request', foreign_key: 'recipient_id'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  validates :username,
  :uniqueness => {
    :case_sensitive => false
  }, :presence => true


  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.search(search)
    if search.present?
      users = []
      users += User.where('email ILIKE ?', search).to_a
      users += User.where('username ILIKE ?', search).to_a
      users
    else
      []
    end
  end

  def does_not_have(book)
    !self.books.map(&:asin).include?(book.asin)
  end

  def requested_user?(user)
    self.requests.map(&:recipient).include?(user)
  end

  def is_following?(user)
    self.follows.find_by(followee: user).present?
  end

  def mutual_follows
    self.followees.to_a.select { |followee| followee.is_following?(self) }
  end


end
