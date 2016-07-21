class Movie < ApplicationRecord

  has_many :reviews
  mount_uploader :image, ImageUploader
  
  # Validations
  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true}
  validates :description, presence: true
  validates :image, presence: true
  validates :release_date, presence: true

  validate :release_date_is_in_the_past


  scope :title_search, ->(title_query) { where("title LIKE ?", "%#{title_query}%") }
  scope :director_search, ->(director_query) { where("director LIKE ?", "%#{director_query}%") }
  scope :runtime_in_minutes_search, ->(runtime_in_minutes_query) { where("runtime_in_minutes >= ? AND runtime_in_minutes <= ?",runtime_in_minutes_query[0],runtime_in_minutes_query[1]) }

  scope :search_all, ->(searched_query, runtime_in_minutes_query ) { where("title LIKE ? OR director LIKE ?", "%#{searched_query}%", "%#{searched_query}%").where("runtime_in_minutes >= ? AND runtime_in_minutes <= ?",runtime_in_minutes_query[0],runtime_in_minutes_query[1])}

  def review_average
    unless reviews.empty?
      reviews.sum(:rating_out_of_ten)/reviews.size 
    else
      '- '
    end
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

end
