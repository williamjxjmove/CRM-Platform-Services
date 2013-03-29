require 'spec_helper'

describe "tpousers/show" do
  before(:each) do
    @tpouser = assign(:tpouser, stub_model(Tpouser,
      :v => "",
      :UserId => "User",
      :ProfileId => "Profile",
      :Day1 => "",
      :New1 => "",
      :Total1 => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/User/)
    rendered.should match(/Profile/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end
