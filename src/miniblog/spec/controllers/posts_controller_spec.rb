require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #delete" do
    it "returns http success" do
      get :delete
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #get_list" do
    it "returns http success" do
      get :get_list
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #post_of_user" do
    it "returns http success" do
      get :post_of_user
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #active_post" do
    it "returns http success" do
      get :active_post
      expect(response).to have_http_status(:success)
    end
  end

end
