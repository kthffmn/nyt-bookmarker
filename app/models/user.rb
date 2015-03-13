class User < ActiveRecord::Base
  has_many :bookmarks
  has_many :articles, :through => :bookmarks

  def unread_articles
    Article.where("id NOT IN (?)", self.article_ids)
  end

  def article_ids
    ids = self.bookmarks.map { |b| b.article_id }
    ids.empty? ? [0] : ids
  end

  def bookmarks_read_eq(boolean)
    self.bookmarks.where(:read? => boolean)
  end

  def read_bookmarks
    bookmarks_read_eq(true)
  end

  def unread_bookmarks
    bookmarks_read_eq(false)
  end

  def has_read_bookmarks?
    read_bookmarks.count > 0
  end

  def has_unread_bookmarks?
    unread_bookmarks.count > 0
  end

end