class Domain < ApplicationRecord
    has_many :image_classes, :dependent => :destroy
end
