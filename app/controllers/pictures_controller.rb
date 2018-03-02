class PicturesController < ApplicationController

  before_action :ensure_logged_in, except: [:show, :index]
  before_action :load_picture, only: [:show, :edit, :update, :destroy]
  # before_action :ensure_user_owns_picture, only: [:edit, :update, :destroy]

  def index
    @most_recent_pictures = Picture.most_recent_three
    @older_pictures = Picture.created_before(Time.now - 3600 * 24 * 30)
    @number_of_older_pictures = @older_pictures.size
  end

  def show
    @picture = Picture.find(params[:id])
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]
    @picture.user_id = current_user.id

    if @picture.save
      redirect_to "/pictures"
    else
      render :new
    end
  end

  def edit
  end

  def update

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]

    if @picture.save
      redirect_to "/pictures/#{@picture.id}"
    else
      render :edit
    end
  end

  def destroy
    @picture.destroy

    redirect_to "/pictures"
  end

  def load_picture
    @picture = Picture.find(params[:id])
  end

end
