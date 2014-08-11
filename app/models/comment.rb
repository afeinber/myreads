class Comment < ActiveRecord::Base
  belongs_to :book, counter_cache: true
  belongs_to :user

  validates! :book, :user, presence: true


  def self.make_comment(comment_params, user, book_asin)
    @comment = Comment.new(comment_params)
    @comment.user = user
    @book = Book.get_book(book_asin)
    @comment.book = @book
    @comment
  end

end
