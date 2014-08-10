class Book < ActiveRecord::Base
  has_many :book_managements
  has_many :users, through: :book_managements
end
