describe "Associations" do
  let(:user) { User.create(:name => "Viola Davis") }
  
  let(:article) { Article.create(:title => "Super Important News") }
  let(:irrelevant_article) { Article.create(:title => "Not Important News") } 
  let(:articles) { [article, irrelevant_article] }
  
  let(:bm_with_article_1) { Bookmark.create(:article_id => article.id, :read => false) }
  let(:bm_with_article_2) { Bookmark.create(:article_id => irrelevant_article.id, :read => true) }
  let(:bookmarks_with_article) { [bm_with_article_1, bm_with_article_2] }

  let(:bm_with_user_1) { Bookmark.create(:user_id => user.id, :read => false) }
  let(:bm_with_user_2) { Bookmark.create(:user_id => user.id, :read => true) }
  let(:bookmarks_with_user) { [bm_with_user_1, bm_with_user_2] }

  describe Bookmark do 
    it "associated with one article" do
      bookmarks_with_article.each do |bookmark|
        expect(bookmark.article.class).to eq(Article)
        expect(bookmark.article.title).to_not be_nil
      end
    end

    it "associated with one user" do
      bookmarks_with_user.each { |b| expect(b.user).to eq(user) }
    end
  end

  describe User do
    it "has many bookmarks" do
      bookmarks_with_article.each { |b| user.bookmarks << b }
      bookmarks_with_article.each { |b| expect(user.bookmarks).to include(b) }
    end

    it "has many articles" do
      articles.each { |a| user.articles << a }
      articles.each { |a| expect(user.articles).to include(a) }
    end
  end

  describe Article do
    let(:kerry) { User.create(name: "Kerry Washington") }
    let(:new_bookmark) { Bookmark.create(user_id: kerry.id, article_id: article.id) }

    it "has many bookmarks" do
      expect(article.bookmarks).to include(bm_with_article_1)
      expect(article.bookmarks).to include(new_bookmark)
    end

    it "has many users" do
      meryl = User.create(name: "Meryl Streep")
      users = [meryl, kerry]
      users.each { |u| article.users << u }
      users.each { |u| expect(article.users).to include(u) }
    end
  end
end
