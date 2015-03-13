require 'rails_helper'
RSpec.describe ApisController, type: :controller do
  describe 'guest access' do
    describe "GET #create_user" do
      it "returns http success" do
        post :create_user, user: attributes_for(:user)
        expect(response).to redirect_to user_login_path
      end
    end

    describe "GET #user_login" do
      it "returns http success" do
        get :user_login
        expect(response).to have_http_status(:success)
      end
    end

    # describe "GET #user_logout" do
    #   it "returns http success" do
    #     get :user_logout
    #     expect(response).to have_http_status(:success)
    #   end
    # end    

    # describe "GET #user_info" do
    #   let(:user) { build(:user) } 
    #   it "returns http success" do
    #     get :user_info
    #     expect(response).to have_http_status(:success)
    #   end
    # end

    # describe "GET #update_user_info" do
    #   it "returns http success" do
    #     put :update_user_info
    #     expect(response).to have_http_status(:success)
    #   end
    # end

    # describe "GET #change_password" do
    #   it "returns http success" do
    #     put :change_password
    #     expect(response).to have_http_status(:success)
    #   end
    # end

    # describe "GET #search_user_by_name" do
    #   it "returns http success" do
    #     get :search_user_by_name
    #     expect(response).to have_http_status(:success)
    #   end
    # end
  end
end
# it "should assign @user and @posts" do
#   expect(@user).to receive(:posts).and_return([@post])
#   expect(User).to receive(:find_by_id).and_return(@user).twice()
#   session["user_id"] = 1
#   get :index, { user_id: 1}
#   expect(assigns(:user)).to be(@user)
#   expect(assigns(:posts)).to eq([@post])
# end