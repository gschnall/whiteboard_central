class AddImagepathToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :imagepath, :string
  end
end
