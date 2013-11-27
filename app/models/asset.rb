class Asset < ActiveRecord::Base

  belongs_to :post
  has_attached_file :image, styles: { large: '640x480', medium: '300x300>', thumb: '100x100>' }

  validates_attachment_content_type :image, content_type: 'image/png'

end