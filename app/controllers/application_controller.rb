class ApplicationController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views/") }

  get "/about" do
    erb :'static_pages/about'
  end

  get "/" do
    erb :'static_pages/home'
  end

end