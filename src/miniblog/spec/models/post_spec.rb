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
      post = Post.create_post(params)
      expect(post[:meta][:code]).to eq 200
    end
    it 'Error validate, Your input dose not match with format string.' do
      params[:title]  = ' '
      post = Post.create_post(params)
      expect(post[:meta][:code]).to eq 2501
    end
  end
  # Test update post
  describe '#Update Post:' do
    let(:post_params) {FactoryGirl.attributes_for(:post)}
    let(:create_post) { Post.create_post(post_params)}
    it 'update post successful.' do
      create_post
      post = Post.update_post(post_params)
      expect(post[:meta][:code]).to eq  200
    end
    it 'Error validate, Your input dose not match with format string.' do
      create_post
      post_params[:title] = "New title"
      post = Post.update_post(post_params)
      expect(post[:meta][:code]).to eq 2502
    end
    it 'Error post, Could be not existed this record.' do
      Post.create_post(post_params)
      post_params[:post_id] = 2
      post = Post.update_post(post_params)
      expect(post[:meta][:code]).to eq 9004
    end
  end
  #   Test get list post
  describe "#Get List Post:" do
    let(:post_params) {build(:post)}
    it 'Get list post successful.' do
      Post.create_post(post_params)
      post = Post.get_list_post(1,0)
      expect(post[:meta][:code]).to eq 200
    end
  end
  # Test get a post
  describe "#Get_A_Post:" do
    let(:post_params) {build(:post)}
    it 'Get list post successful.' do
      Post.create_post(post_params)
      post = Post.get_a_post(Post.first[:id])
      expect(post[:meta][:code]).to eq 200
    end
  end
  #  Test get_all_post_for_user
  describe "#Get_all_post_for_user" do
    let(:post_params) {build(:post)}
    it 'Get list post successful.' do
      Post.create_post(post_params)
      post = Post.get_a_post(1)
      expect(post[:meta][:code]).to eq 200
    end
  end
  # Test Delete Post
  describe "#Delete post" do
    let(:post_params) {FactoryGirl.attributes_for(:post)}
    let(:create_post) { Post.create_post(post_params)}
    it "Delete successful." do
      create_post
      post_delete = Post.delete_post(post_params)
      expect(post_delete[:meta][:code]).to eq 200
    end
    it "Delete failed." do
      create_post
      post_delete = Post.delete_post('s')
      expect(post_delete[:meta][:code]).to eq 2503
    end
  end
  # Test active post
  describe "#Active Post" do
    let(:post_params) {FactoryGirl.attributes_for(:post)}
    it 'update active successful.' do
      post_params[:post_id] = Post.first[:id]
      post = Post.active_post(post_params)
      expect(post[:meta][:code]).to eq  200
    end
  end
end
