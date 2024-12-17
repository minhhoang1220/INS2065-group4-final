class User < ApplicationRecord
  has_person_name
  has_one :usertable, dependent: :destroy
  accepts_nested_attributes_for :usertable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
