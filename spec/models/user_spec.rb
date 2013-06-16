require "spec_helper"

describe User do

  it "current_time_zone defaults to Pacific Time" do
    user = User.create!(email: "whatever@jeff.is", password: "test", password_confirmation: "test")
    expect(user.current_time_zone).to eq(ActiveSupport::TimeZone.new("Pacific Time (US & Canada)"))
  end

  it "current_time_zone is correct" do
    user = User.create!(email: "whatever@jeff.is", password: "test", password_confirmation: "test")
    tz = user.records.create!(raw: "time zone, Tokyo", target: Time.now - 5.minutes)
    one = user.records.create!(raw: "workout, swim, 3200 yards", target: Time.now)
    expect(user.current_time_zone).to eq(ActiveSupport::TimeZone.new("Tokyo"))
  end

end
