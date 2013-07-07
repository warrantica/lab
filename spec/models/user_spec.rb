require 'spec_helper'

describe User do
  before do
  	@user = User.new(name: "Example User", email: "user@example.com", 
  		password: "testtest", password_confirmation: "testtest")
  end
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "Name should not be blank" do
  	before { @user.name = " " }
  	it { should_not be_valid }
  end

  describe "Email should not be blank" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end

  describe "Name should not be too long" do
  	before { @user.name = "a" * 51 }
  	it { should_not be_valid }
  end

  describe "Invalid email" do
  	it "Should be rejected" do
  		addresses = %w[user@foo,com user_at_foo.org example.s@mm. 
  			a@b_c.com xdx@y+s.com]
  		addresses.each do |invalid_email|
  			@user.email = invalid_email
  			@user.should_not be_valid
  		end
  	end
  end

  describe "Valid email" do
  	it "Should be accepted" do
  		addresses = %w[user@foo.COM A_bcd-efg@hey.com.com 
  			x.y+z@hello.in.th]

  		addresses.each do |valid_email|
  			@user.email = valid_email
  			@user.should be_valid
  		end
  	end
  end

  describe "When email is already taken" do
  	before do
  		user_duplication = @user.dup
  		user_duplication.email = @user.email.upcase
  		user_duplication.save
  	end

  	it { should_not be_valid }
  end

  describe "When password is not present" do
  	before { @user.password = @user.password_confirmation = " " }
  	it { should_not be_valid }
  end

  describe "When password is not the same as confirmation" do
  	before { @user.password_confirmation = "sthelse" }
  	it { should_not be_valid }
  end

  describe "When password_confirmation is nil" do
  	before { @user.password_confirmation = nil }
  	it { should_not be_valid }
  end

  describe "Password too short" do
  	before { @user.password = @user.password_confirmation = "a" *5}
  	it {should be_invalid }
  end

  describe "Return value of authentication method" do
  	before { @user.save }
  	let(:found_user) { User.find_by_email(@user.email) }

  	describe "with valid password" do
  		it { should == found_user.authenticate(@user.password) }
  	end

  	describe "with invalid password" do
  		let(:user_for_invalid_password) { 
  			found_user.authenticate("invalid") }

  		it { should_not == user_for_invalid_password }
  		specify { user_for_invalid_password.should be_false }
  	end
  end

end
