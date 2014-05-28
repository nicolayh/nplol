class Post < ActiveRecord::Base
  validates :title, presence: true,
            length: {minimum: 5},
            uniqueness: true

  validates :content, presence: true
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  has_many :comments, dependent: :destroy
  has_many :assets
  accepts_nested_attributes_for :assets, :allow_destroy => true

  acts_as_taggable

  def asset_attributes=(asset_ids)
    assets.clear
    asset_ids.each do |asset_id|
      assets << Asset.find(asset_id)
    end
  end

  def type
    (self.is_a? Meme) ? 'meme' : 'post'
  end

  def meme?
    self.is_a? Meme
  end

  def next?
    Post.where("id > #{id}").order('id ASC').first
  end

  def previous?
    Post.where("id < #{id}").order('id DESC').first
  end

end
