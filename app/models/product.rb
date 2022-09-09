class Product < ApplicationRecord
  include ProductsHelper

  belongs_to :user

  has_many :comments,dependent: :destroy
  has_many_attached :images, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  validates :name,:brand, length: { minimum: 3 },presence: :true
  validates :price, :numericality => { :greater_than_or_equal_to => 0 }
  validate :image_type

  after_create  :set_serial_number

  def thumbnail input
    self.images[input].variant(resize: "150x150!").processed
  end

  def image_type
    if images.attached? == false
      errors.add(:images, "are missing!")
    end
    images.each do |image|
      if !image.content_type.in?(%("image/jpeg image/png image/jpg"))
        errors.add(:images, "Upload the valid Images")
      end
    end
  end
  # byebug

  def set_serial_number
    self.update(serial_no: "#{created_at.to_i}-#{id}")
  end
end
