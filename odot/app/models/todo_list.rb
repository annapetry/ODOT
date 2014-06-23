# == Schema Information
#
# Table name: todo_lists
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

class TodoList < ActiveRecord::Base
  has_many :todo_items
  belongs_to :user
  
  validates :title, presence: true
  validates :title, length: { minimum: 3 }
  
  validates :description, presence: true
  validates :description, length: { minimum: 5 }
  
  def has_completed_items?
    todo_items.complete.size > 0
  end
  
  def has_incomplete_items?
    todo_items.incomplete.size > 0
  end
end
