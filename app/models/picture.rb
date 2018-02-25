class Picture < ApplicationRecord

  def self.newest_first
    Picture.order("created_at DESC")
  end

  def self.most_recent_three
    Picture.newest_first.limit(3)
  end

  def self.created_before(time)
    Picture.where("created_at < ?", time)
  end

end
