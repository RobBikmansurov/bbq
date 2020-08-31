class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events

  validates :name, presence: true, length: { maximum: 35 }

  before_validation :rand_name, on: :create

  private

  def rand_name
    self.name = "Товарисч #{rand(1000)}"
  end
end
