require 'spec_helper'

describe User do
  let(:valid_attributes) { 
    {
      first_name: "Anna",
      last_name: "Petry",
      email: "hello@annapetry.com"
    }
  }
  
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
    
  
end
