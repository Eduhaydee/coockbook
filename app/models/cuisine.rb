class Cuisine < ApplicationRecord
  has_many :recipe
  validates :name, presence: true
  validates :name, uniqueness: { message: "O nome informado já existe!" }
end
