class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  belongs_to :department
  belongs_to :office

  def self.ransackable_attributes(auth_object = nil)
    ["email", "screen_name", "status"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["department", "office"]
  end
end
