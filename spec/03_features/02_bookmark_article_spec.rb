describe "Bookmarking Articles" do

  let(:name)   { 'Lucretia Mott' }
  let(:avatar) { 'http://www.rschindler.com/mott.jpg' }
  let(:user)   { User.create(:name => name, :avatar => avatar) }
  
  before do
    visit "/users/#{user.id}"
  end

  it "links to the article index page" do
    expect(page).to have_link('View Articles')
    click_link('View Articles')
    expect(URI.parse(current_url).path).to eq("/users/#{user.id}/articles")
  end

  it "each article has a radio button for clicking 'Mark as read' or 'Add to List'" do
    click_link('View Articles')
    num_of_articles = Article.count
    selectors = [
      "input[name='bookmark[user_id]']",
      "input[name='bookmark[article_id]']",
      "input[name='bookmark[read]'][value='false']",
      "input[name='bookmark[read]'][value='true']",
      "input[value='Submit']"
    ]
    selectors.each do |selector|
      expect(page).to have_selector(selector, count: num_of_articles)
    end
  end

  it "allows user to click 'Mark as Read' and then 'Submit'" do
    original_article_count = user.articles.count
    last_bookmark = Bookmark.last
    click_link('View Articles')
    choose('Mark as read', :match => :first)
    click_button('Submit', :match => :first)
    expect(URI.parse(current_url).path).to eq("/users/#{user.id}")

    latest_bookmark = Bookmark.last
    expect(latest_bookmark).to_not eq(last_bookmark)
    expect(latest_bookmark.user_id).to eq(user.id)
    expect(latest_bookmark.read).to eq(true)
    expect(user.articles.count).to eq(original_article_count + 1)

    expect(page).to have_content(latest_bookmark.article.title)
    expect(page).to have_content(latest_bookmark.article.byline)
    expect(page).to have_content(latest_bookmark.article.abstract)
  end

  it "allows user to click 'Add to List' and then 'Submit'" do
    original_article_count = user.articles.count
    last_bookmark = Bookmark.last
    click_link('View Articles')
    choose('Add to list', :match => :first)
    click_button('Submit', :match => :first)
    expect(URI.parse(current_url).path).to eq("/users/#{user.id}")

    latest_bookmark = Bookmark.last
    expect(latest_bookmark).to_not eq(last_bookmark)
    expect(latest_bookmark.user_id).to eq(user.id)
    expect(latest_bookmark.read).to eq(false)
    expect(user.articles.count).to eq(original_article_count + 1)

    expect(page).to have_content(latest_bookmark.article.title)
    expect(page).to have_content(latest_bookmark.article.byline)
    expect(page).to have_content(latest_bookmark.article.abstract)
  end
end
