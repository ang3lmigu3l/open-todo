class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :permissions, inclusion: { in: %w(public viewable private),
    message: "%{value} not valid. Must be public or private" }

  def self.permission_options
    %w(private viewable open)
  end

  def add(item_description)
    if items.create(description: item_description)
      true
    else
      false
    end
  end

  def remove(item_description)
    if item = items.find_by(description: item_description)
      item.mark_complete
    else
      false
    end
  end
end
