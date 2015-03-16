describe User do

  before(:all) do
    @user = User.create(:name => "Dee", :avatar => "http://dee.jpg.to/")
    first_article = Article.all.sample
    second_article = Article.all.sample
    third_article = Article.all.sample
    @unread_bm = Bookmark.create(:user_id => @user.id, :article_id => first_article.id, :read => false)
    first_read_bm = Bookmark.create(:user_id => @user.id, :article_id => second_article.id, :read => true)
    second_read_bm = Bookmark.create(:user_id => @user.id, :article_id => third_article.id, :read => true)
    @read_bookmarks = [first_read_bm, second_read_bm]
  end

  describe "#read_bookmarks" do
    it "knows about all the articles it has read" do
      expect { @user.read_bookmarks }.to_not raise_error
      expect(@user.read_bookmarks.length).to eq(@read_bookmarks.length)
      @read_bookmarks.each { |bm| expect(@user.read_bookmarks).to include(bm) }
      expect(@user.read_bookmarks).to_not include(@unread_bm)
    end
  end

  describe "#unread_bookmarks" do
    it "knows about all the articles it has bookmarked but hasn't read" do
      expect { @user.unread_bookmarks }.to_not raise_error
      expect(@user.unread_bookmarks).to include(@unread_bm)
      @read_bookmarks.each { |bm| expect(@user.unread_bookmarks).to_not include(bm) }
    end
  end
end
