class Bookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  def self.delete_associated_bookmarks(relation)
    relation.bookmarks.destroy_all
  end
end