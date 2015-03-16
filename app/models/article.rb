class Article < ActiveRecord::Base
  has_many :bookmarks
  has_many :users, :through => :bookmarks

  def self.unbookmarked_articles(user)
    self.where("id NOT IN (?)", user.article_ids)
  end

end