require "test_helper"

describe HomepagesController do
  it "should get index" do
    get homepages_index_url
    value(response).must_be :success?
  end

  it "should get show" do
    get homepages_show_url
    value(response).must_be :success?
  end

end
