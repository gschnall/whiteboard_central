class User < ActiveRecord::Base
  has_secure_password
  has_many :boards
  accepts_nested_attributes_for :boards

  #validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("name like ?", "%#{query}%") 
  end
end
