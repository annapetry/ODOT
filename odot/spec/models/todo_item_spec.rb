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

require 'spec_helper'

describe TodoItem do
  it { should belong_to(:todo_list) }
  
  describe "#completed?" do
    let!(:todo_item) { TodoItem.create(content: "Hello") }
    
    it "is false when completed_at is blank" do
      todo_item.completed_at = nil
      expect(todo_item.completed?).to be_falsey
    end
    
    it "returns true when completed_at is not empty" do
      todo_item.completed_at = Time.now
      expect(todo_item.completed?).to be_truthy
    end
    
  end
end
