class User < ApplicationRecord
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
