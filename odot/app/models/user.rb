# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  first_name           :string(255)
#  last_name            :string(255)
#  email                :string(255)
#  password_digest      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  password_reset_token :string(255)
#

class User < ActiveRecord::Base
  has_secure_password
  
  has_many :todo_lists
  
  validates :email, presence: true, 
                    uniqueness: true,
                    format: {
                      with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9\.-]+\.[A-Za-z]+\Z/
                    }
  
  
  before_save :downcase_email
  
  def downcase_email
    self.email = email.downcase
  end
  
  def generate_password_reset_token!
    update_attribute(:password_reset_token, SecureRandom.urlsafe_base64(48))
  end
end
