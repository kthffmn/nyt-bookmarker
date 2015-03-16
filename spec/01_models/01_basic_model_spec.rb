describe "Basics" do
  describe User do
    it "has a name" do
      expect { User.create(:name => "Arianaaaa Grande") }.to_not raise_error
      user = User.create(:name => "Arianaaaa Grande")
      user.name = "Ariana Grande"
      user.save
      expect(User.find_by(:name => "Ariana Grande").name).to eq("Ariana Grande")
    end

    it "has an avatar" do
      expect { User.create(:avatar => "http://pic.jpg") }.to_not raise_error
      user = User.create(:avatar => "http://pic.jpg")
      user.avatar = "http://img.png"
      user.save
      expect(User.find_by(:avatar => "http://img.png").avatar).to eq("http://img.png")
    end
  end

  describe Article do
    it "has a url" do
      expect { Article.create(:url => "http://articleee.com") }.to_not raise_error
      article = Article.create(:url => "http://articleee.com")
      article.url = "http://article.com"
      article.save
      expect(Article.find_by(:url => "http://article.com").url).to eq("http://article.com")
    end

    it "has a byline" do
      expect { Article.create(:byline => "By AMY CHOZICK and MICHAEL S. SCHMIDT") }.to_not raise_error
      article = Article.create(:byline =>"By AMY CHOZICK and MICHAEL S. SCHMIDT")
      article.byline = "By AMY CHOZICK"
      article.save
      expect(Article.find_by(:byline => "By AMY CHOZICK").byline).to eq("By AMY CHOZICK")
    end

    it "has a title" do
      expect { Article.create(:title => "Not important news") }.to_not raise_error
      article = Article.create(:title => "Not important news")
      article.title = "Breaking News"
      article.save
      found = Article.find_by(:title => "Breaking News")
      expect(found.title).to eq("Breaking News")
    end

    it "has an abstract" do
      original = "You like a style? One of the Paris Fashion Week Shows was certain to have it."
      update = "Identical twins who shared the same sports and other physical..."
      expect { Article.create(:abstract => original) }.to_not raise_error
      article = Article.create(:abstract => original)
      article.abstract = update
      article.save
      expect(Article.find_by(:abstract => update).abstract).to eq(update)
    end
  end

  describe Bookmark do
    it "has a article_id" do
      first_article = Article.create(:title => "First Article")
      second_article = Article.create(:title => "Second Article")
      
      expect { Bookmark.create(:article_id => first_article.id) }.to_not raise_error
      bookmark = Bookmark.create(:article_id => first_article.id)
      bookmark.article_id = second_article.id
      bookmark.save
      found = Bookmark.find_by(:article_id => second_article.id)
      expect(found.article_id).to eq(second_article.id)
    end

    it "has a user_id" do
      first_user = User.create(:name => "First User")
      second_user = User.create(:name => "Second User")
      
      expect { Bookmark.create(:user_id => first_user.id) }.to_not raise_error
      bookmark = Bookmark.create(:user_id => first_user.id)
      bookmark.user_id = second_user.id
      bookmark.save
      found = Bookmark.find_by(:user_id => second_user.id)
      expect(found.user_id).to eq(second_user.id)
    end

    it "knows if the article has been read" do
      leah = User.create(:name => "Leah Suter")
      article = Article.create(:title => "Partying Like It's 1995")
      expect { Bookmark.create(:read => false, :user_id => leah.id, :article_id => article.id) }.to_not raise_error
      bookmark = Bookmark.create(:read => false, :user_id => leah.id, :article_id => article.id)
      bookmark.read = true
      bookmark.save
      id = bookmark.id
      found = Bookmark.find(id)
      expect(found.read).to eq(true)
    end
  end
end
