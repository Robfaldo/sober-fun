class Event < ApplicationRecord
  # https://medium.com/@sherzelsmith/add-a-filtering-multiple-tag-system-with-autocomplete-to-your-rails-model-in-rails-5-1bf88cd53e9
  belongs_to :user
  validates :title, :description, :location, :time, :date, :presence => true
  has_many :taggings
  has_many :tags, through: :taggings

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
