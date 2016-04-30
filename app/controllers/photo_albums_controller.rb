class PhotoAlbumsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @photo_album = PhotoAlbum.find(params[:id])
  end

  def new
    @photo_album = PhotoAlbum.new
  end

  def create
    @photo_album = current_user.photo_albums.new(photo_album_params)
    if @photo_album.save
      redirect_to @photo_album, notice: "Successfully created a new album!"
    else
      flash.now[:alert] = "Oops, something went wrong"
      render :new
    end
  end

  def edit
  end

  private

    def photo_album_params
      params.require(:photo_album).permit(:title, :description, { photos: [] })
    end
end
