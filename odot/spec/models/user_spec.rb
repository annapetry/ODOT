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

require 'spec_helper'

describe User do
  let(:valid_attributes) { 
    {
      first_name: "Anna",
      last_name: "Petry",
      email: "hello@annapetry.com",
      password: "treehouse",
      password_confirmation: "treehouse"
    }
  }
  
  context "validations" do
    it { should have_many(:todo_lists) }
  end
  
  context "validations" do
    let(:user) { User.new(valid_attributes) }
    
    before do
      User.create(valid_attributes)
    end
    
    it "requires an email" do
      expect(user).to validate_presence_of(:email)
    end
    
    it "requires a unique email" do
      expect(user).to validate_uniqueness_of(:email)
    end
    
    it "requires a unique email (case insenstive)" do
      user.email = "ANNA@PETRY.COM"
      expect(user).to validate_uniqueness_of(:email)
    end
    
    it "requires the email address to look like an email" do
      user.email = "anna"
      expect(user).to_not be_valid
    end
    
  end
    
    describe "#downcase_email" do
      it "makes the email attribute to lower case" do
        user = User.new(valid_attributes.merge(email: "ANNA@PETRY.COM"))
        expect{ user.downcase_email }.to change{ user.email }.
        from("ANNA@PETRY.COM").
        to("anna@petry.com")
      end
    end
    
    it "downcases an email before saving" do
      user = User.new(valid_attributes)
      user.email = "ANNA@PETRY.COM"
      expect(user.save).to be_truthy
      expect(user.email).to eq("anna@petry.com")
    end
    
    describe "#generate_password_reset_token" do
      let(:user) { create :user }
      
      it "changes the password_reset_token attribute" do
        expect{ user.generate_password_reset_token! }.to change{user.password_reset_token}
      end
      
      it "calls SecureRandom.urlsafe_base64 to generate the password_reset_token" do
        expect(SecureRandom).to receive(:urlsafe_base64)
        user.generate_password_reset_token!
      end
    end
  
end
