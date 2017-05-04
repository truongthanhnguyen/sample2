class Micropost < ApplicationRecord
  has_many :comments, dependent: :destroy
  default_scope -> {order(created_at: :desc)}
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.micropost.content_length}
  validate :picture_size
  validates :title, presence: true, length: {maximum: Settings.micropost.title_length}

  private

    def picture_size
      if picture.size > Settings.micropost.picture_size.megabytes
        errors.add(:picture, t("micropost.should_be"))
      end
    end
end
