require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  # Test create user
  describe ".create_user" do
    let(:leanhthang){build(:user)}
    it "should create a new instance given a valid attribute" do
      User.create_user(leanhthang)
    end
  end
  # Test model login
  describe ".user_login" do
    let(:params) {{username: 'leanhthang', password: '18121990'}}
    let(:new_user){User.create_user(build(:user))}
    context 'successfully' do
      it 'Username and password match' do
        result = User.user_login(params)
        expect(result[:meta][:code]).to eq 200
      end
    end
    context 'If user, password wrong.' do
      let(:params){{username: 'vovantan', password: '18121990'}}
      it 'username and password dose not match' do
        result = User.user_login(params)
        expect(result[:meta][:code]).to eq 2007
      end
    end
  end

  # Test change password
  describe ".change_password" do
    let(:params){{password: '18121990', new_password: '20909090', password_confirmation: '20909090'}}
    let(:new_user){User.create_user(build(:user))}
    let(:user_id){User.first.id}
    context 'The older password dose not match.' do
      let(:params){{password: '131231233'}}
      it "should request the password matching with database" do
        change_pass = User.change_password(user_id,params)
        expect(change_pass[:meta][:code]).to eq 2006
      end
    end
    context 'If change password to successful.' do
      it 'Response successful' do
        change_pass = User.change_password(user_id,params)
        expect(change_pass[:meta][:code]).to eq 200
      end
    end
  end

  # Test get user info
  describe ".get_user_info" do
    let(:new_user){User.create_user(build(:user))}
    let(:user_id){User.first.id}
    context 'Get user info' do
      it 'should request the user id exists.' do
        user = User.get_user_info(user_id)
        expect(user).to_not eq nil
      end
    end
  end

  # Test get update user
  describe ".update_user" do
    let(:new_user){User.create_user(build(:user))}
    let(:user_id){User.first.id}
    context 'If data validation wrong.' do
      let(:params){{email: 'vo_tan@mulodo.com', username: 'vovantan'}}
      it "should be sending data input matching format model database." do
        # @user = 
        @user = User.update_user(user_id,params)
        # User.User.update_user(user_id,params)(user_id,params)
        expect(@user[:meta][:code]).to eq 200
      end
    end
    context 'successful.' do
      let(:params){{email: 'vo.tan@mulodo.com'}}
      it "update was successful." do
        @user = User.update_user(user_id,params)
        # User.User.update_user(user_id,params)
        # User.where(id: 1).update_all(email: 'lad.d@gas.com')
        expect(@user[:meta][:code]).to eq 200
      end
    end
  end

  # Test search user by name
  describe ".search_user_by_name" do
    let(:new_user){User.create_user(build(:user))}
    let(:params) {{keyword:'leanh', limit: 2, offset: 2 }}
    context 'successful.' do
      it "search successful." do
        user =  User.search_user_by_name("leanhthang",1,2)
        expect(user[:meta][:code]).to eq 200
      end
    end
    context 'search false.' do
      it "should be sending keyword." do
        user =  User.search_user_by_name(nil,1,2)
        expect(user[:meta][:code]).to eq 1000
      end
    end
  end
end
