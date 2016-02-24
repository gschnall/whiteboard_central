class BoardsController < ApplicationController
  require 'base64'
  require 'mini_magick'

  def index
    @board = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
  end
  
  # FOR SOME REASON YOU NEED THIS FOR AJAX TO WORK??
  protect_from_forgery

  def create
    @img_path = Time.now.strftime("%d%m%Y%h%M%S") + "_" + (0...16).map {('a'..'z').to_a[rand(26)] }.join  
    File.open("#{Rails.root}/public/uploads/boards/#{@img_path}.png", 'wb') do |f|
      f.write(params[:image].read)
    end  
    @board = Board.new
    # Declare Image Attributes
    @board.imagepath = @img_path + ".png"
    img = MiniMagick::Image.open("#{Rails.root}/public/uploads/boards/#{@img_path}.png")
    @board.width = img.width
    @board.height = img.height
    @board.likes = 0
    @board.private = false 
    #User.find(session[:user_id]).boards << @board
    # Save Board
    if @board.save
      flash[:success] = "White Board Saved Son!"
    else
      flash[:failure] = "Oops, There was a problem...Please Try again later."
    end
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    if @board.update_attributes(board_params)
      redirect_to board_path @board
    end
  end

  def destroy
    @board = Board.find(params[:id])
    if @board.destroy
      redirect_to root_path 
    end
  end

  private
    def board_params
      params.require(:board).permit(:title) #tag_list later 
    end
#Controller Ending
end
