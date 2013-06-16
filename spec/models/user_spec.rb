require "spec_helper"

describe User do

  it "gets current_time_zone when there are no records" do
    user = User.create!(email: "whatever@jeff.is", password: "test")
    expect(user.current_time_zone).to eq(ActiveSupport::TimeZone.new("Pacific Time (US & Canada)"))
  end

end
