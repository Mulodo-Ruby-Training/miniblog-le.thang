require 'rails_helper'

RSpec.describe Post, type: :model do
  it "has a valid factory" do
    expect(build(:post)).to be_valid
  end
  # Test post create
  describe '#Create post' do
    let(:params) {build(:post)}
    let(:user) { User.create_user(build(:user))}
    it 'create post successful.' do
      user
      post = Post.create_post(User.select(:id).first[:id],params)
      expect(Post.count).to eq 1
    end
    it 'Error validate, Your input dose not match with format string.' do
      params[:title]  = nil
      user
      post = Post.create_post(User.select(:id).first[:id],params)
      expect(Post.count).to eq 0
    end
  end
  # Test update post
  describe '#Update Post:' do
    let(:post_params) {build(:post)}
    let(:user) { User.create_user(build(:user))}
    it 'update post successful.' do
      user
      Post.create_post(User.select(:id).first[:id],post_params)
      post = Post.update_post(Post.select(:id).first[:id],post_params)
      expect(post[:meta][:code]).to eq  200
    end
    it 'Error validate, Your input dose not match with format string.' do
      Post.create_post(User.select(:id).first[:id],post_params)
      post = Post.update_post(nil,post_params)
      expect(post[:meta][:code]).to eq 2501
    end
  end
  #   Test get list post
  describe "#Get List Post:" do
    let(:post_params) {build(:post)}
    let(:user) { User.create_user(build(:user))}
    it 'Get list post successful.' do
      user
      Post.create_post(User.select(:id).first[:id],post_params)
      post = Post.get_list_post(1,0)
      expect(post[:meta][:code]).to eq 200
    end
  end
  # Test get a post
  describe "#Get_A_Post:" do
    let(:post_params) {build(:post)}
    let(:user) { User.create_user(build(:user))}
    it 'Get list post successful.' do
      user
      Post.create_post(User.select(:id).first[:id],post_params)
      post = Post.get_a_post(Post.first[:id])
      expect(post[:meta][:code]).to eq 200
    end
  end
  #  Test get_all_post_for_user
  describe "#Get_all_post_for_user" do
    let(:post_params) {build(:post)}
    let(:user) { User.create_user(build(:user))}
    it 'Get list post successful.' do
      user
      Post.create_post(User.select(:id).first[:id],post_params)
      post = Post.get_a_post(Post.first[:id])
      expect(post[:meta][:code]).to eq 200
    end
  end
  # Test Delete Post
  describe "#Delete post" do
    
  end
  # Test active post
  describe "#Active Post" do
    let(:post_params) {build(:post)}
    let(:user) { User.create_user(build(:user))}
    it 'update post successful.' do
      user
      Post.create_post(User.select(:id).first[:id],post_params)
      post = Post.update_post(Post.select(:id).first[:id],post_params)
      expect(post[:meta][:code]).to eq  200
    end
    it 'Error validate, Your input dose not match with format string.' do
      Post.create_post(User.select(:id).first[:id],post_params)
      post = Post.update_post(nil,post_params)
      expect(post[:meta][:code]).to eq 2501
    end
  end
end
