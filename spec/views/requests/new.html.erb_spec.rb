require 'spec_helper'

describe "requests/new" do
  before(:each) do
    assign(:request, stub_model(Request).as_new_record)
  end

  it "renders new request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => requests_path, :method => "post" do
    end
  end
end
