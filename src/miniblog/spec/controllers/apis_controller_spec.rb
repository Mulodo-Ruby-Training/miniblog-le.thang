require 'rails_helper'
require 'spec_helper'
RSpec.describe ApisController, type: :controller do
  let(:params_user) { FactoryGirl.attributes_for(:user) }
  let(:params_post) { FactoryGirl.attributes_for(:post) }
  let(:params_com) { FactoryGirl.attributes_for(:comment) }
  let(:create_user) { User.create_user(params_user)}
  let(:login) {User.user_login('leanhthang','18121990')}

  # ================    APIs     ================= #
  # ================    User     ================= #
  describe "GET index" do
    it 'create user success' do
      params_user[:password_confirmation] = '18121990'
      post :create_user, params_user
      expect(JSON.parse(response.body)["meta"]["code"]).to eq 200
    end
    it 'Error validate' do
      # attributes[:password_confirmation] = '18121990'
      post :create_user, params_user
      expect(JSON.parse(response.body)["meta"]["code"]).to eq 1001
    end
  end

  # ================    APIs     ================= #
  # ================    Post     ================= #



  # ================    APIs     ================= #
  # ================   Comment   ================= #
  describe "Create Comment" do
    it "should create comment successful" do
      create_user
      login
      post :create_comment, params_com
      expect(JSON.parse(response.body)["meta"]["code"]).to eq login
    end
  end
  describe "Update comment" do
    it "should " do

    end
  end

end
