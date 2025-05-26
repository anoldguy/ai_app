class Player < ApplicationRecord
  has_one_attached :photo

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :birthdate, presence: true
  validate :photo_format
  validate :birthdate_not_in_future

  scope :adults, -> { where('birthdate <= ?', 18.years.ago) }
  scope :by_age, -> { order(:birthdate) }
  scope :by_name, -> { order(:name) }

  def age
    return nil unless birthdate.present?
    
    today = Date.current
    age = today.year - birthdate.year
    age -= 1 if today < birthdate + age.years
    age
  end

  def adult?
    age && age >= 18
  end

  def display_age
    return "Unknown age" unless age
    "#{age} years old"
  end

  private

  def photo_format
    return unless photo.attached?

    unless photo.content_type.in?(['image/jpeg', 'image/jpg', 'image/png', 'image/gif'])
      errors.add(:photo, 'must be a JPEG, PNG, or GIF image')
    end

    if photo.byte_size > 5.megabytes
      errors.add(:photo, 'must be less than 5MB')
    end
  end

  def birthdate_not_in_future
    return unless birthdate.present?
    
    if birthdate > Date.current
      errors.add(:birthdate, 'cannot be in the future')
    end
    
    if birthdate < 120.years.ago
      errors.add(:birthdate, 'cannot be more than 120 years ago')
    end
  end
end
