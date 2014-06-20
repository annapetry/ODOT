require 'spec_helper'

describe UserSessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
    
    it "renders the new template" do
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe "POST 'create'" do
    context "with correct credentials" do
      let!(:user) { User.create(first_name: "Anna", 
                    last_name: "Petry", 
                    email: "hello@annapetry.com", 
                    password: "password", 
                    password_confirmation: "password")}
                    
      it "redirects to the todo list path" do
        post :create, email: "hello@annapetry.com", password: "password"
        expect(response).to be_redirect
        expect(response).to redirect_to(todo_lists_path)
      end
    
      it "finds the user" do
        expect(User).to receive(:find_by).with({email: "hello@annapetry.com"}).and_return(user)
         post :create, email: "hello@annapetry.com", password: "password"
      end
    
      it "authenticates the user" do
        User.stub(:find_by).and_return(user) # Uses stub method to stub the 'find_by' method, making it return the specific user
        expect(user).to receive(:authenticate)
        post :create, email: "hello@annapetry.com", password: "password"                  
      end
    end
  end

end
