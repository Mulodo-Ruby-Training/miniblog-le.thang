require 'rails_helper'
require 'spec_helper'
RSpec.describe ApisController, type: :controller do
  let(:attributes) { FactoryGirl.attributes_for(:user) }
  let(:params_login){{username: 'leanhthanga', password: '18121990'}}
  # Cotroller test User.create_user
  # describe "POST create_user" do
  #   context "with valid attributes" do
  #     it "create new user account" do
  #       post :create_user, attributes
  #       Profile.count.should eq(1)
  #       User.count.should eq(1)
  #     end
  #     it 'responds with status: 200' do
  #       post :create_user, FactoryGirl.attributes_for(:user)
  #       expect(JSON.parse(response.body)["meta"]["status"]).to eq(200)
  #     end
  #   end

  describe "GET index" do
    # it 'login success' do
    #   user = User.create_user(attributes)
    #   login = User.user_login (params_login)
    #   expect(login[:meta][:code]).to eq 200
    # end

    it "assigns @users" do
      # post :create_user, {user: attributes}
      # # get :user_logout
      # post :user_login, params_login
      # parameters = ActionController::Parameters.new(attributes)
      # user = User.create_user(parameters.permit(:username, :password, :email, :first_name, :last_name, :avatar, :display_name, :birthday, :address))
      # user = User.create_user(attributes)
      # search = get :search_user_by_name, {keyword: 'leanhthang', limit: 1, offset: 0}
      # p = parameters.require(:user).permit(:username, :password, :email, :first_name, :last_name, :avatar, :display_name, :birthday, :address)
       # user =
      # h = Hash.new
      # h[:user] = attributes
      # p = h.to_json
      # post :create_user, p
      # expect( User.count).to eq p
    end

    # it "renders the index template" do
    #   get :search_user_by_name
    #   expect(response).to render_template(users_path)
    # end
  end
end




    # context "create new user account:" do
    #   it "Test create success response code 200" do
    #     # post :create_user, attributes
    #     # expect(response.to_a.to_s).to
    #     # eq 200
    #     user = create_user(attributes)
    #     User.count.should eq(1)
    #   end
    #   # validate
    #   # let(:new_attr){FactoryGirl.build(:user, email: 'New email').attributes.symbolize_keys }
    #   # it "Validate error. Response code 1000", focus: true do
    #   #   user = User.create_user new_attr
    #   #   expect(user[:meta][:code]).to eq 1000
    #   # end
    # end
  # end
