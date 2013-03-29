require 'spec_helper'

describe "tpousers/index" do
  before(:each) do
    assign(:tpousers, [
      stub_model(Tpouser,
        :v => "",
        :UserId => "User",
        :ProfileId => "Profile",
        :Day1 => "",
        :New1 => "",
        :Total1 => ""
      ),
      stub_model(Tpouser,
        :v => "",
        :UserId => "User",
        :ProfileId => "Profile",
        :Day1 => "",
        :New1 => "",
        :Total1 => ""
      )
    ])
  end

  it "renders a list of tpousers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "User".to_s, :count => 2
    assert_select "tr>td", :text => "Profile".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
