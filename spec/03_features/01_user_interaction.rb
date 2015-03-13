# describe "Feature - Get Requests", type: :request  do

#   let(:title) { 'Air KONG Squeaker Tennis Balls' }
#   let(:product) { Product.find_by(title: title) }
#   let(:home_welcome) { "Welcome to Pets 'n Stuff!" }
#   let(:product_welcome) { "Welcome to the Products Page" }

#   context "Home Page" do
#     before do
#       visit "/"
#     end

#     it "displays welcome message" do
#       expect(page).to have_content(home_welcome)
#     end

#     it "links to '/products'" do
#       visit "/"
#       click_link('Products')
      
#       expect(URI.parse(current_url).path).to eq("/products")
#       expect(page).to have_content(product_welcome)
      
#       about_message = "Pets 'n Stuff is a locally owned pet shop based in Brooklyn. We specialize in providing toys that will entertain and engage your pets."
#       expect(page).to have_content(about_message)
#     end
#   end

#   context "Products" do
#     context "#index" do
#       before do
#         visit "/products"
#       end

#       it "links back to the home page" do
#         expect(page).to have_content('« Back')
#         click_link('« Back')
#         expect(page).to have_content(home_welcome)
#       end

#       it "displays every product with their price and title" do
#         expect(page).to have_content(product_welcome)
#         3.times do
#           product = Product.all.sample
#           # if product.nil?
#           #   binding.pry
#           # end
#           expect(page).to have_content(product.title)
#           expect(page).to have_content(product.price)
#         end
#       end

#       it "links to each product's show page" do
#         3.times do
#           product = Product.all.sample
#           expect(page).to have_link(product.title)
#         end
#       end

#       it "can click on links to each product's show page" do
#         first(:link, title).click
#         expect(URI.parse(current_url).path).to eq("/products/#{product.id}")
#         click_link('« Back')
#         lazer_title = "Petsport Laser Chase II"
#         lazer = Product.find_by(title: lazer_title)
#         first(:link, lazer_title).click
#         expect(URI.parse(current_url).path).to eq("/products/#{lazer.id}")
#       end
#     end

#     context "#show" do
#       before do
#         visit "/products/#{product.id}"
#       end

#       it "displays all info on the product" do
#         expect(page).to have_content("#{product.title}")
#         expect(page).to have_content("#{product.price}")
#         expect(page).to have_xpath("//img[@src=\"/images/#{product.slug}.jpg\"]")
#         expect(page).to have_link("« Back")
#       end

#       it "can click on a link to go back to the products index" do
#         click_link("« Back")
#         expect(page).to have_content(product_welcome)
#       end
#     end

#     context "#new" do
#       before do
#         visit "/products/new"
#       end

#       it "displays the form for creating a new product" do
#         expect(page).to have_content("Add a product")
#         expect(page).to have_selector("input[type=submit][value='Submit']")
#       end

#       it 'the form is suggests text for each box using placeholders' do
#         expect(page).to have_selector("input[name='product[title]'][placeholder='Chew toy']")
#         expect(page).to have_selector("input[name='product[slug]'][placeholder='chew_toy']")
#         expect(page).to have_selector("input[name='product[price]'][placeholder='$5.99']")
#       end

#       it "can click on a link to go back to the products index" do
#         click_link("« Back")
#         expect(page).to have_content(product_welcome)
#         expect(URI.parse(current_url).path).to eq("/products")
#       end
#     end

#     context "#edit" do
#       before do
#         visit "/products/#{product.id}/edit"
#       end

#       it "displays the form for creating a new product" do
#         expect(page).to have_content("Editing Product")
#         expect(page).to have_selector("input[type=submit][value='Submit']")
#         expect(page).to have_selector("input[name='product[title]'][value='#{product.title}']")
#         expect(page).to have_selector("input[name='product[slug]'][value='#{product.slug}']")
#         expect(page).to have_selector("input[name='product[price]'][value='#{product.price}']")
#       end

#       it 'the form is pre-populated with the correct values' do
#         expect(page).to have_selector("input[name='product[title]'][value='#{product.title}']")
#         expect(page).to have_selector("input[name='product[slug]'][value='#{product.slug}']")
#         expect(page).to have_selector("input[name='product[price]'][value='#{product.price}']")
#       end

#       it "can click on a link to go back to the products index" do
#         click_link("« Back")
#         expect(page).to have_content(product.title)
#         expect(URI.parse(current_url).path).to eq("/products/#{product.id}")
#       end
#     end
#   end
# end
