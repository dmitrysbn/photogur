class Picture < ApplicationRecord

  validates :artist, :url, presence: true

  validates :title, length: { in: 3..20 }

  validates :url, uniqueness: true

  def self.newest_first
    Picture.order("created_at DESC")
  end

  def self.most_recent_three
    Picture.newest_first.limit(3)
  end

  def self.created_before(time)
    Picture.where("created_at < ?", time)
  end

  def self.pictures_created_in(year)
    Picture.where("created_at > ? and created_at < ?", Date.new(year,1,1), Date.new(year,12,31))
  end

end
