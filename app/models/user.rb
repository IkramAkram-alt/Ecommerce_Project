class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one_attached :avatar, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :orders
  has_one  :cart, dependent: :destroy

  validates :firstName,:lastName, format: { with: /\A[a-zA-Z]+\z/, message: "Only letters allowed" }, length: { minimum: 3 }

  before_validation :set_full_name, :set_role

  after_commit :add_default_avatar, on: %i[create update]
  after_create :set_cart

  attr_accessor :firstName,:lastName,:user_role
  rolify



  def first_name
    name.split(' ')[0]
  end

  def last_name
    name.split(' ')[1]
  end

  def set_full_name
    self.name = [firstName, lastName].join(' ')
  end

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "125x125!").processed
    else
      "/default_profile.jpeg"
    end
  end

  def set_cart
    self.create_cart
  end

 private

  def set_role
    user_role == "seller" ? self.add_role(user_role) : self.add_role("buyer")
  end

  def add_default_avatar
    unless avatar.attached?
        avatar.attach(
          io: File.open(
            Rails.root.join(
              'app','assets', 'images','default_profile.jpeg'
            )
          ),
          filename: "default_profile.jpeg",
          content_type: "image/jpeg"
        )
    end
  end

end
