class Photo < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes,    as: :likeable
  
  mount_uploader :file, PhotoUploader

  validates_integrity_of  :file
  validates_processing_of :file
  validate :file_size
  
  validates :description, presence: true, length: { maximum: 255 }

  private

    def file_size
      errors[:file] << "should be less than 3.0MB" if file.size > 3.0.megabytes
    end
end
