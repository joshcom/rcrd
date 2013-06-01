require 'spec_helper'

describe "Records" do

  it "should not be able to load records_path without authenticating" do
    get records_path
    response.status.should be(302) # should redirect to root_url
  end

  it "should not be able to load a record without authenticating" do
    one = Record.create!(raw: "workout, swim", target: Time.now)
    get record_path one
    response.status.should be(302) # should redirect to root_url
  end

  it "should be able to load records_path once authenticated" do
    one = User.create!(email: "hi@jeff.is")
    get "/sessions/new?passcode=#{ENV['RCRD_PASSCODE']}&id=#{one.id.to_s}"
    get records_path
    response.status.should be(200)
  end

  it "should be able to load a record once authenticated" do
    one = User.create!(email: "hi@jeff.is")
    get "/sessions/new?passcode=#{ENV['RCRD_PASSCODE']}&id=#{one.id.to_s}"
    two = Record.create!(raw: "workout, swim", target: Time.now)
    get record_path two 
    response.status.should be(200)
  end

end
