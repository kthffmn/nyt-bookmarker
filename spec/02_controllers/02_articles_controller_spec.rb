describe ArticlesController do

  let(:user) { 
    User.create(
      :name => "Susan B. Anthony", 
      :avatar => "http://upload.wikimedia.org/wikipedia/commons/c/c4/Susan_B_Anthony_c1855.png"
    )
  }

  context "GET" do
    describe "#index" do
      before do
        get "/users/#{user.id}/articles"
      end

      it "responds with a 200 status code" do
        expect(last_response).to be_ok
      end

      it "renders the index template" do
        3.times do
          article = Article.all.sample
          expect(last_response.body).to include(article.title)
          expect(last_response.body).to include("<a target=\"_blank\" href=")
          expect(last_response.body).to include(article.url)
          expect(last_response.body).to include(article.byline)
          expect(last_response.body).to include(article.abstract)
        end
      end
    end
  end
end
