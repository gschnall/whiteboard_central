class BoardsController < ApplicationController
  before_action :authorize 
    
  #@user = current_user
  require 'base64'
  require 'fileutils'
  #require 'mini_magick'
  skip_before_filter :verify_authenticity_token

  #before_action :authorize, only:[:new]

  def index
    @board = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
  end
  
  # protect_from_forgery

  def create
    # CHECK IF BOARD IS BEING UPDATED OR CREATED
    @update_board = @board ? true : false
    if @update_board # if board is being updated
      @board = Board.find(params[:id])
      @img_path = Boards.imagepath + ".png"
    else # if board brand new 
      @board = current_user.boards.new()
      @img_path = Time.now.strftime("%d%m%Y%h%M%S") + "_" + (0...16).map {('a'..'z').to_a[rand(26)] }.join  
    end
    # Proceed to Update or Create new board
    File.open("#{Rails.root}/public/images/#{@img_path}.png", 'wb') do |f|
      f.write(params[:image].read)
    end  
    #@board = Board.new
    # Declare Image Attributes
    @board.imagepath = @img_path + ".png"
    img = MiniMagick::Image.open("#{Rails.root}/public/images/#{@img_path}.png")
    @board.width = img.width
    @board.height = img.height
    @board.likes = 0
    @board.private = false 
    if @board.save
      redirect_to edit_board_path(@board)
      flash[:success] = "White Board Saved Son!"
    else
      flash[:failure] = "Oops, There was a problem...Please Try again later."
    end
  end

  def edit
    #logger.debug Board.find(params[:id])
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    @img_path = Time.now.strftime("%d%m%Y%h%M%S") + "_" + (0...16).map {('a'..'z').to_a[rand(26)] }.join  
    #logger.debug @img_path
    File.open("#{Rails.root}/public/images/#{@img_path}", "wb") { |f|
        f.write(params[:image].read)
    }
    FileUtils.rm("#{Rails.root}/public/images/#{@board.imagepath}") 
    @board.imagepath = @img_path
    if @board.save
      redirect_to(:back)
    end
  end

  def destroy
    @board = Board.find(params[:id])
    FileUtils.rm("#{Rails.root}/public/images/#{@board.imagepath}") 
    if @board.destroy
      redirect_to(:back) 
    end
  end

  def makePrivate
    @board = Board.find(params[:id])
    if @board.private
      @board.private = false;
    else
      @board.private = true;
    end
    if @board.save
      redirect_to(:back)
    end
  end

  private
    def board_params
      params.require(:board).permit(:tag_list) 
    end
#Controller Ending
end
