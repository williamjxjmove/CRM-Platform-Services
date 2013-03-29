require 'spec_helper'

describe Tpouser do
   #region Test Suite Setup

  before { @user = User.new(
    v: 1,
    UserId: "userid",
    ProfileId: "profileid",
    Day1: "2013-04-01",
    New1: 666,
    Total1: 888
    )    
  }
  
  subject { @user }

  #endregion

  #region Verify Structure

  describe "should have the correct properties" do
    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:age) }
  end

  #endregion

  #region Verify Validation

  describe "should be invalid with incorrect values" do
    describe "because of missing first name" do
      before { @user.first_name = "" }
      it { should_not be_valid }
    end
    
    describe "because the last name is too short" do
      before { @user.last_name = "a" * 2 }
      it { should_not be_valid }
    end
    
    describe "because of missing last name" do
      before { @user.last_name = "" }
      it { should_not be_valid }
    end

    describe "because of missing age" do
      before { @user.age = nil }
      it { should_not be_valid }
    end
  end

  #endregion
end
