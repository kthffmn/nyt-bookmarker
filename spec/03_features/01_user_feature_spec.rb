describe "User Sign Up, Delete Account, and Edit Profile" do

  let(:name) { 'Grace Greenwood' }
  let(:avatar) { 'http://utc.iath.virginia.edu/sentimnt/images/greenwoodhp1.jpg' }

  before do
    visit "/"
  end

  it "displays welcome message" do
    expect(page).to have_content('NYT Article Bookmarker')
    mission = 'Let us help you find and remember New York Times articles that interest you.'
    expect(page).to have_content(mission)
  end

  it "links to '/users/new'" do
    click_link('Sign Up »')
    expect(URI.parse(current_url).path).to eq("/users/new")
    expect(page).to have_content('Create an Account')
  end

  it "from '/users/new', users can click 'Back'" do
    click_link('Sign Up »')
    click_link("« Back")
    expect(URI.parse(current_url).path).to eq("/")
  end

  it "'/users/new' displays the form for creating a new product" do
    click_link('Sign Up »')
    expect(page).to have_selector("input[name='user[name]'][placeholder='Selena Gomez']")
    expect(page).to have_selector("input[name='user[avatar]'][placeholder='http://image.cdn.ispot.tv/topic/Ic/selena-gomez.png']")
    expect(page).to have_selector("input[type=submit][value='Sign Up']")
  end

  it "'/users/new' redirects to the user show page upon form submission" do
    click_link('Sign Up »')
    fill_in('user[name]', :with => name)
    fill_in('user[avatar]', :with => avatar)
    click_button("Sign Up")
    user = User.find_by(:name => name)
    expect(User.last).to eq(user)
    expect(URI.parse(current_url).path).to eq("/users/#{user.id}")
  end

  it "from show, users can click 'Delete Your Account' and their account is deleted" do
    click_link('Sign Up »')
    fill_in('user[name]', :with => 'Katie')
    fill_in('user[avatar]', :with => "https://avatars3.githubusercontent.com/u/5709920?v=3&s=460")
    click_button("Sign Up")
    user = User.find_by(:name => 'Katie')
    
    click_button('Delete Your Account')
    
    expect(URI.parse(current_url).path).to eq("/")
    expect(User.find_by(:name => 'Katie')).to be_nil
    expect { User.find(user.id) }.to raise_error
  end

  it "from show, users can click 'Edit Profile' and update their profile" do
    old_attributes = {
      :name => 'Blaaake',
      :avatar => "https://avatars3.githubusercontent.com/u/453844?v=3&s=460"
    }
    new_attributes = {
      :name => 'Blake',
      :avatar => "https://pbs.twimg.com/profile_images/577513029849460736/Bp-g22JN_400x400.jpeg"
    }
    
    click_link('Sign Up »')
    fill_in('user[name]', :with => old_attributes[:name])
    fill_in('user[avatar]', :with => old_attributes[:avatar])
    click_button("Sign Up")

    user = User.find_by(:name => old_attributes[:name])

    click_link('Edit Profile')

    expect(URI.parse(current_url).path).to eq("/users/#{user.id}/edit")
    expect(page).to have_selector("input[name='user[name]'][value='#{old_attributes[:name]}']")
    expect(page).to have_selector("input[name='user[avatar]'][value='#{old_attributes[:avatar]}']")
    
    fill_in('user[name]', :with => new_attributes[:name])
    fill_in('user[avatar]', :with => new_attributes[:avatar])
    click_button('Submit')
    
    expect(URI.parse(current_url).path).to eq("/users/#{user.id}")

    expect(page).to_not have_content(old_attributes[:name])
    expect(page).to have_content(new_attributes[:name])

    expect(page.find('.avatar')['src']).to_not eq(old_attributes[:avatar])
    expect(page.find('.avatar')['src']).to eq(new_attributes[:avatar])
  end
end
