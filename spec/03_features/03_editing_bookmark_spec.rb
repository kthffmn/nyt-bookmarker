describe "Editing Bookmarks" do
  before(:all) do
    @user = User.create(
      :name => 'David Walker', 
      :avatar => 'http://uscivilliberties.org/uploads/posts/2013-10/1383113418_david-walker-17951830.jpg'
    )
    first_article = Article.find_by(:title => "Forty Portraits in Forty Years")
    unread_bookmark = Bookmark.create(
      :article_id => first_article.id,
      :user_id => @user.id,
      :read => false
    )
    second_article = Article.find_by(:title => "Partying Like It's 1995")
    read_bookmark = Bookmark.create(
      :article_id => second_article.id,
      :user_id => @user.id,
      :read => true
    )
    @bookmarks = [unread_bookmark, read_bookmark]
  end

  before(:each) do
    visit "/users/#{@user.id}"
  end

  it "user/show displays the bookmarked articles in the list" do
    @bookmarks.each do |bookmark|
      expect(page).to have_content(bookmark.article.title)
      expect(page).to have_content(bookmark.article.byline)
    end
  end

  it "user/show has a button to mark unread articles as read" do
    original_unread_count = @user.bookmarks.where(:read => false).count
    original_read_count = @user.bookmarks.where(:read => true).count

    expect(page).to have_selector("input[type='hidden'][value='patch'][name='_method']")
    expect(page).to have_selector("input[type='hidden'][value='true'][name='bookmark[read]']")
    expect(page).to have_selector("input[type='submit'][value='Mark as Read']")
    click_button('Mark as Read', :match => :first)

    expect(@user.bookmarks.where(:read => true).count).to eq(original_read_count + 1)
    expect(@user.bookmarks.where(:read => false).count).to eq(original_unread_count - 1)
  end

  it "user/show has a button to mark read articles as unread" do
    original_unread_count = @user.bookmarks.where(:read => false).count
    original_read_count = @user.bookmarks.where(:read => true).count
    
    expect(page).to have_selector("input[type='hidden'][value='patch'][name='_method']")
    expect(page).to have_selector("input[type='hidden'][value='false'][name='bookmark[read]']")
    expect(page).to have_selector("input[type='submit'][value='Mark as Unread']")
    click_button("Mark as Unread", :match => :first)

    expect(@user.bookmarks.where(:read => true).count).to eq(original_read_count - 1)
    expect(@user.bookmarks.where(:read => false).count).to eq(original_unread_count + 1)
  end

  it "user/show has a button to delete the association to the article" do
    original_count = @user.bookmarks.count

    expect(page).to have_selector("input[type='hidden'][value='delete'][name='_method']")
    expect(page).to have_selector("input[type='submit'][value='Remove']")
    click_button('Remove', :match => :first)

    expect(@user.bookmarks.count).to eq(original_count - 1)
  end
end
