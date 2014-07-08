class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :comments
  has_many :books, through: :listed_books
  has_many :listed_books

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
    if search
      users = []
      users += User.where('email ILIKE ?', search).to_a
      users += User.where('username ILIKE ?', search).to_a
      users
    else
      []
    end
  end


end
