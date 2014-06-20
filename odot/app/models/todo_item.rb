# == Schema Information
#
# Table name: todo_items
#
#  id           :integer          not null, primary key
#  todo_list_id :integer
#  content      :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  completed_at :datetime
#

class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  
  validates :content, presence: true,
                      length: { minimum: 2 }
                      

  scope :complete, -> { where("completed_at is not null") }
  scope :incomplete, -> { where(completed_at: nil) }

  def completed?
    !completed_at.blank?
  end
end
