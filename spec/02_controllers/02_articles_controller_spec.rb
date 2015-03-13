# describe ArticlesController do

#   context "GET" do
#     describe "#index" do
#       before do
#         get "/products"
#       end

#       it "responds with a 200 status code" do
#         expect(last_response).to be_ok
#       end

#       it "renders the index template" do
#         expect(last_response.body).to include("Welcome to the Products Page")
#         3.times do
#           product = Product.all.sample
#           expect(last_response.body).to include(product.title)
#           expect(last_response.body).to include(product.price)
#           expect(last_response.body).to include("<img src=\"/images/#{product.slug}.jpg\"")
#           expect(last_response.body).to include("<a href=\"/products/#{product.id}\"")
#         end
#       end
#     end

#     describe "#show" do
#       let(:back_button) { '<a href="/products" class="btn btn-primary">&laquo; Back</a>'}
#       before do
#         @product = Product.all.sample
#         get "/products/#{@product.id}"
#       end

#       it "responds with a 200 status code" do
#         expect(last_response).to be_ok
#       end

#       it "renders the show template" do
#         expect(last_response.body).to_not include("Welcome to the Products Page")
#         expect(last_response.body).to_not include("<a href=\"/products/#@{product.id}\"")

#         expect(last_response.body).to include("Out of stock")
#         expect(last_response.body).to include("Edit")
#         expect(last_response.body).to include(back_button)        
#         expect(last_response.body).to include(@product.title)
#         expect(last_response.body).to include(@product.price)
#         expect(last_response.body).to include("<img src=\"/images/#{@product.slug}.jpg\"")
#       end
#     end

#     describe "#new" do
#       let(:back_button) { '<a href="/products" class="btn btn-primary">&laquo; Back</a>'}
#       let(:attributes) { ["title", "slug", "price"] }
#       let(:submit_button) { '<input type="submit" value="Submit" class="btn btn-default">' }
#       let(:form) { '<form action="/products" method="post">' }
#       before do
#         get "/products/new"
#       end

#       it "responds with a 200 status code" do
#         expect(last_response).to be_ok
#       end

#       it "renders the new template" do
#         expect(last_response.body).to include("Add a product")   
#         expect(last_response.body).to include(form) 
#         attributes.each do |attribute|
#           field_name = "name=\"product[#{attribute}]\">"
#           expect(last_response.body).to include(field_name)  
#         end
#         expect(last_response.body).to include(submit_button)
#       end
#     end

#     describe "#edit" do
#       let(:attributes) { ["title", "slug", "price"] }
#       let(:patch_method) { '<input type="hidden" name="_method" value="patch">' }
#       let(:submit_button) { }
#       before do
#         @product = Product.all.sample
#         get "/products/#{@product.id}/edit"
#       end

#       it "responds with a 200 status code" do
#         expect(last_response).to be_ok
#       end

#       it "renders the edit template" do
#         expect(last_response.body).to include("Editing Product")  
#         form = "<form action=\"/products/#{@product.id}\" method=\"post\">" 
#         expect(last_response.body).to include(form)
#         expect(last_response.body).to include(patch_method)

#         attributes.each do |attribute|
#           field_name = "name=\"product[#{attribute}]\">"
#           expect(last_response.body).to include(field_name)
#           expect(last_response.body).to include(@product.send(attribute))
#         end

#         submit_button = "<form action=\"/products/#{@product.id}\" method=\"post\">"
#         expect(last_response.body).to include(submit_button)
#       end
#     end
#   end

#   context "POST" do
#     describe "#create" do
#       before(:all) do
#         @title = 'goDog Mini Plush Orange & Blue Dragon Dog Toy'
#         @slug = 'dragon_toy'
#         @price = '$8.23'
#         params =  {
#           :'product[title]' => @title, 
#           :'product[slug]' => @slug, 
#           :'product[price]' => @price
#         }
#         post "/products", params
#         follow_redirect!  
#       end

#       it "adds the product to the database" do
#         product = Product.find_by(:title => @title)
#         expect(product.id).to_not be_nil
#         expect(product.slug).to eq(@slug)
#         expect(product.price).to eq(@price)
#       end

#       it "redirects to the product's show page" do
#         product = Product.find_by(:title => @title)
#         expect(last_request.url).to eq("http://example.org/products/#{product.id}")
#       end
#     end
#   end

#   context "PATCH" do
#     describe "#update" do
#       before(:all) do
#         @old_attributes = {
#           :title => 'Puurple Monkie',
#           :slug => 'puurple_monkie',
#           :price => '$110.00'
#         }
#         @updated_attributes = {
#           :title => 'Purple Monkey',
#           :slug => 'puurple_monkey',
#           :price => '$11.00'
#         }
#         @product = Product.create(@old_attributes)
#         params =  {
#           :'product[title]' => @updated_attributes[:title], 
#           :'product[slug]' => @updated_attributes[:slug], 
#           :'product[price]' => @updated_attributes[:price]
#         }
#         patch "/products/#{@product.id}", params
#         follow_redirect!
#       end

#       it "updates the database" do
#         found = Product.find_by(:title => @old_attributes[:title])
#         expect(found).to be_nil
#       end

#       it "redirects to the product's show page" do
#         expect(last_request.url).to eq("http://example.org/products/#{@product.id}")
#       end

#       it "updates all the attributes" do
#         @old_attributes.each do |type, value|
#           expect(last_response.body).to_not include(value)
#         end
#         @updated_attributes.each do |type, value|
#           expect(last_response.body).to include(value) unless type == :slug
#         end
#         image = "<img src=\"/images/#{@updated_attributes[:slug]}.jpg\""
#         expect(last_response.body).to include(image)
#       end
#     end
#   end

#   context "DELETE" do
#     describe "#destory" do
#       before do
#         @attributes = {
#           :title => 'Plush Elephant Toy',
#           :slug => 'elephant_toy',
#           :price => '$19.23'
#         }
#         @product = Product.create(@attributes)
#         delete "/products/#{@product.id}/destroy"
#         follow_redirect!
#       end

#       it "responds with a 200 status code" do
#         expect(last_response).to be_ok
#       end

#       it "redirects to the index template" do
#         expect(last_response.body).to include("Welcome to the Products Page")
#         3.times do
#           product = Product.all.sample
#           expect(last_response.body).to include(product.title)
#           expect(last_response.body).to include(product.price)
#           expect(last_response.body).to include("<img src=\"/images/#{product.slug}.jpg\"")
#           expect(last_response.body).to include("<a href=\"/products/#{product.id}\"")
#         end
#       end

#       it "deletes the product from the database" do
#         temp_attributes = @attributes
#         temp_attributes[:id] = @product.id
#         temp_attributes.each do |attribute, value|
#           found = Product.find_by(attribute => value)
#           expect(found).to be_nil
#         end
#       end

#       it "does not display the deleted item on the index page" do
#         expect(last_response.body).to_not include(@attributes[:title])
#         expect(last_response.body).to_not include(@attributes[:price])
#         expect(last_response.body).to_not include("<img src=\"/images/#{@attributes[:slug]}.jpg\"")
#       end
#     end
#   end
# end
