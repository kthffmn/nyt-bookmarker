describe BookmarksController do

  let(:harriet) { 
    User.create(
      :name => "Harriet Beecher Stowe", 
      :avatar => "http://cdn2.americancivilwar.com/americancivilwar-cdn/women/harriet_beecher_stowe.jpg"
    )
  }
  
  let(:matilda) { 
    User.create(
      :name => "Matilda Joslyn Gage", 
      :avatar => "http://upload.wikimedia.org/wikipedia/commons/thumb/2/28/MatildaJoslynGage.jpeg/220px-MatildaJoslynGage.jpeg"
    )
  }

  let(:article) { 
    Article.find_by(:title => "Apple Watch Success Will Hinge on Apps") 
  }

  let(:bookmark_params) {
    {
      :article_id => article.id,
      :user_id => matilda.id,
      :read => false
    }
  }

  let(:bookmark) { Bookmark.create(bookmark_params) }

  context "POST" do
    describe "#create" do
      before do
        @params = {
          "bookmark[article_id]" => article.id,
          "bookmark[user_id]" => harriet.id,
          "bookmark[read]" => false
        } 
        post "/bookmarks", @params
        follow_redirect!
      end

      it "responds with a 200 status code" do
        expect(last_response).to be_ok
      end

      it "redirects to the user's show page" do
        expect(last_request.url).to eq("http://example.org/users/#{harriet.id}")
      end

      it "creates a bookmark that joins the article with the user" do
        found_bookmarks = Bookmark.where(
          :article_id => article.id,
          :user_id => harriet.id,
          :read => false
        )
        found = found_bookmarks.first
        expect(found).to_not be_nil
        expect(found.class).to eq(Bookmark)
        expect(harriet.bookmarks).to include(found)
        expect(harriet.articles).to include(article)
        expect(article.bookmarks).to include(found)
        expect(article.users).to include(harriet)
      end
    end
  end

  context "PATCH" do

    describe "#update" do
      before do
        @params = {
          "bookmark[read]" => true
        } 
        patch "/bookmarks/#{bookmark.id}", @params
        follow_redirect!
      end

      it "responds with a 200 status code" do
        expect(last_response).to be_ok
      end

      it "redirects to the user's show page" do
        expect(last_request.url).to eq("http://example.org/users/#{matilda.id}")
      end

      it "updates the bookmark that joins the article with the user" do
        unread_bookmarks = Bookmark.where(
          :article_id => article.id,
          :user_id => matilda.id,
          :read => false
        )
        expect(unread_bookmarks).to be_empty

        read_bookmarks = Bookmark.where(
          :article_id => article.id,
          :user_id => matilda.id,
          :read => true
        )
        found = read_bookmarks.first
        expect(found).to_not be_nil
        expect(found.class).to eq(Bookmark)
      end
    end
  end

  context "POST" do
    describe "#create" do
      before do
        @params = {
          "bookmark[article_id]" => article.id,
          "bookmark[user_id]" => harriet.id,
          "bookmark[read]" => false
        } 
        post "/bookmarks", @params
        follow_redirect!
      end

      it "responds with a 200 status code" do
        expect(last_response).to be_ok
      end

      it "redirects to the user's show page" do
        expect(last_request.url).to eq("http://example.org/users/#{harriet.id}")
      end

      it "creates a bookmark that joins the article with the user" do
        found_bookmarks = Bookmark.where(
          :article_id => article.id,
          :user_id => harriet.id,
          :read => false
        )
        found = found_bookmarks.first
        expect(found).to_not be_nil
        expect(found.class).to eq(Bookmark)
        expect(harriet.bookmarks).to include(found)
        expect(harriet.articles).to include(article)
        expect(article.bookmarks).to include(found)
        expect(article.users).to include(harriet)
      end
    end
  end

  context "DELETE" do
    describe "#destroy" do
      before do
        delete "/bookmarks/#{bookmark.id}"
        follow_redirect!
      end

      it "responds with a 200 status code" do
        expect(last_response).to be_ok
      end

      it "redirects to the user (whose id was the user_id) show page" do
        expect(last_request.url).to eq("http://example.org/users/#{matilda.id}")
      end

      it "deletes the bookmark that joined the article with the user" do
        found_bookmarks = Bookmark.where(bookmark_params)
        expect(found_bookmarks).to be_empty
      end
    end
  end
end
