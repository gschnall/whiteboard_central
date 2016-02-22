class BoardsController < ApplicationController
  def index
    @board = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      redirect_to board_path @board
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
      redirect_to user_path @board.user
    end
  end

  private
    def board_params
      params.require(:board).permit(:title, :tag_list) 
    end
end
