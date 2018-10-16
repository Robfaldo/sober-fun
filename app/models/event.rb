class Event < ApplicationRecord
  # https://medium.com/@sherzelsmith/add-a-filtering-multiple-tag-system-with-autocomplete-to-your-rails-model-in-rails-5-1bf88cd53e9
  belongs_to :user
  validates :title, :price, :description, :location, :time, :date, :presence => true
  has_many :taggings
  has_many :tags, through: :taggings
  scope :free, -> { where(price: 0) }
  scope :under10, -> { where('price > 0 AND price <= 1000') }
  scope :ten_to_thirty, -> { where('price > 1000 AND price <= 3000') }

  SAFE_PARAMS = ['free', 'under10', 'ten_to_thirty']

  def self.price_filter(*filter_params)
    events = []
    filter_params.first.each do |filter|
      raise 'not a safe param' unless SAFE_PARAMS.include?(filter)
      events.push(eval(filter))
    end
    return events
  end

  def self.tagged_with(name)
    Tag.find_by!(name: name).events
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
