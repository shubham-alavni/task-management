class User < ApplicationRecord
  has_secure_password

  has_many :tasks, dependent: :destroy

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  def name
    first_name.capitalize + " " + last_name.capitalize
  end
end
