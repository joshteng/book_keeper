class User < ActiveRecord::Base
  include Clearance::User

  has_many :book_managements
  has_many :books, through: :book_managements

end
