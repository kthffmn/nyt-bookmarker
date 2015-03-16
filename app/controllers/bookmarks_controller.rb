class BookmarksController < ApplicationController
  
  post '/bookmarks' do
    @bookmark = Bookmark.new(params[:bookmark])
    @user = @bookmark.user
    if @bookmark.save
      redirect "/users/#{@bookmark.user.id}" 
    else
      render :'users/show'
    end
  end

  patch '/bookmarks/:id' do
    @bookmark = Bookmark.find(params[:id])
    @user = @bookmark.user
    if @bookmark.update(params[:bookmark])
      redirect "/users/#{@user.id}" 
    else
      erb :'users/show'
    end
  end

  delete '/bookmarks/:id' do
    @bookmark = Bookmark.find(params[:id])
    @user = @bookmark.user
    if @bookmark.delete
      redirect "/users/#{@user.id}"
    else
      render :'users/show'
    end
  end

end