describe User do

  before(:all) do
    @hilary = User.create(:name => "Hilary Swank", :avatar => "http://hilaryswank.jpg.to/")
    @amal = User.create(:name => "Amal Clooney", :avatar => "http://amalclooney.jpg.to/")
    @ucla_article = Article.find_by(:title => "In U.C.L.A. Debate Over Jewish Student, Echoes on Campus of Old Biases")

    @first_article  = Article.find_by(:title => "Did a Human or a Computer Write This?")
    @second_article = Article.find_by(:title => "The Feel-Good Gene")
    @third_article  = Article.find_by(:title => "With the Clintons, Only the Shadow Knows")
    @forth_article  = Article.find_by(:title => "It's Not Always Depression")
    all_articles = [@first_article, @second_article, @third_article, @forth_article]
    
    @hilarys_bookmarked_articles = all_articles.map do |article|
      b = Bookmark.create(:user_id => @hilary.id, :article_id => article.id, :read => false)
      b.article
    end

    @amals_bookmarked_articles = [@first_article, @third_article].map do |article|
      b = Bookmark.create(:user_id => @amal.id, :article_id => article.id, :read => false)
      b.article
    end

    @hilary.bookmarks.last.update(:read => true)
  end

  describe ".unbookmarked_articles" do
    it "accepts one argument, a user object" do
      expect { Article.unbookmarked_articles(@hilary) }.to_not raise_error
    end

    it "returns all the articles that the user hasn't bookmarked" do
      hilarys_unbookmarked_articles = Article.unbookmarked_articles(@hilary)
      expect(hilarys_unbookmarked_articles).to include(@ucla_article)
      
      @hilarys_bookmarked_articles.each do |article|
        expect(hilarys_unbookmarked_articles).to_not include(article)
      end
      
      hilarys_total_articles = 
        hilarys_unbookmarked_articles.count +
        @hilarys_bookmarked_articles.count
      expect(hilarys_total_articles).to eq(Article.all.count)
    end 

    it "doesn't hardcode the answer" do
      amals_unbookmarked_articles = Article.unbookmarked_articles(@amal)
      expect(amals_unbookmarked_articles).to include(@ucla_article)
      
      @amals_bookmarked_articles.each do |article|
        expect(amals_unbookmarked_articles).to_not include(article)
      end
      
      [@second_article, @forth_article].each do |article|
        expect(amals_unbookmarked_articles).to include(article)
      end
      
      amals_total_articles = 
        amals_unbookmarked_articles.count + 
        @amals_bookmarked_articles.count
      expect(amals_total_articles).to eq(Article.all.count)
    end
  end
end
