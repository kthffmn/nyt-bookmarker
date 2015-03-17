class ArticlesController < ApplicationController
  
  get '/users/:user_id/articles' do
    @user = User.find(params[:user_id])
    @articles = Article.all
    erb :'articles/index'
  end

end
  