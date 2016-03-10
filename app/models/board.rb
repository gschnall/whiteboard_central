class Board < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable
  mount_uploader :title #image_uploader

  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("LOWER(tag_list) like ?", "%#{query.downcase}%") 
  end
end
