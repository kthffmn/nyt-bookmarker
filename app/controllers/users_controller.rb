class UsersController < ApplicationController

  get '/users' do
    @users = User.all
    erb :'users/index'
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'users/show'
  end

  patch '/users/:id' do
    @user = User.find(params[:id])
    if @user.update(params[:user])
      redirect "/users/#{@user.id}" 
    else
      erb :'users/edit'
    end
  end

  post '/users' do
    @user = User.new(params[:user])
    if @user.save
      redirect "/users/#{@user.id}" 
    else
      erb :'users/new'
    end
  end

  get '/users/:id/edit' do
    @user = User.find(params[:id])
    erb :'users/edit'
  end

  delete '/users/:id' do
    @user = User.find(params[:id])
    Bookmark.delete_associated_bookmarks(@user)
    if @user.destroy
      redirect "/"
    else
      erb :"users/#{@user.id}"
    end
  end

end
  