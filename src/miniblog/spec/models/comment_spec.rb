require 'rails_helper'

RSpec.describe Comment, type: :model do

  # Test comment create
  describe '#Create comment' do
    let(:params) {FactoryGirl.attributes_for(:comment)}
    it 'create comment successful.' do
      comm = Comment.create_comment(params)
      expect(comm[:meta][:code]).to eq 200
    end
  end
  # Test comment update
  describe '#Update comment' do
    let(:params) {FactoryGirl.attributes_for(:comment)}
    let(:comment) {Comment.create_comment(params)}
    it 'Update comment successful.' do
      comment
      comm = Comment.update_comment(params)
      expect(comm[:meta][:code]).to eq 200
    end
  end
  # Test comment delete
  describe '#Delete comment' do
    let(:params) {FactoryGirl.attributes_for(:comment)}
    let(:comment) {Comment.create_comment(params)}
    it 'Delete comment successful.' do
      comment
      comm = Comment.delete_comment(params)
      expect(comm[:meta][:code]).to eq 200
    end
  end
  # Test get_all_comment_for_a_post
  describe '#get_all_comment_for_a_post' do
    let(:params) {FactoryGirl.attributes_for(:comment)}
    let(:comment) {Comment.create_comment(params)}
    it 'get_all_comment_for_a_post successful.' do
      comment
      comm = Comment.get_all_comment_for_a_post(1,1,0)
      expect(comm[:meta][:code]).to eq 200
    end
  end
  # Test get_all_comment_for_user
  describe '#get_all_comment_for_user' do
    let(:params) {FactoryGirl.attributes_for(:comment)}
    let(:comment) {Comment.create_comment(params)}
    it 'get_all_comment_for_user successful.' do
      comment
      comm = Comment.get_all_comment_for_user(1,1,0)
      expect(comm[:meta][:code]).to eq 200
    end
  end
end
