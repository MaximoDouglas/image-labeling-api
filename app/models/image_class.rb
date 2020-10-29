class ImageClass < ApplicationRecord
  belongs_to :domain
  has_many :images, :dependent => :destroy
end
