require "spec_helper"

describe Record do

  it "gets the default time_zone_text" do
    user = User.create!(email: "whatever@jeff.is", password: "test")
    one = user.records.create!(raw: "workout, swim, 3200 yards", target: Time.now)
    expect(one.time_zone_text).to eq("Pacific Time (US & Canada)")
  end

  it "gets the correct time_zone_text" do
    user = User.create!(email: "whatever@jeff.is", password: "test")
    tz = user.records.create!(raw: "time zone, Tokyo", target: Time.now - 5.minutes)
    one = user.records.create!(raw: "workout, swim, 3200 yards", target: Time.now)
    expect(one.time_zone_text).to eq("Tokyo")
  end

  it "time_zone" do
    user = User.create!(email: "whatever@jeff.is", password: "test")
    tz = user.records.create!(raw: "time zone, Tokyo", target: Time.now - 5.minutes)
    one = user.records.create!(raw: "workout, swim, 3200 yards", target: Time.now)
    expect(one.time_zone).to eq(ActiveSupport::TimeZone.new("Tokyo"))
  end

  it "local_target" do
    user = User.create!(email: "whatever@jeff.is", password: "test")
    tz = user.records.create!(raw: "time zone, Tokyo", target: Time.now - 5.minutes)
    one = user.records.create!(raw: "workout, swim, 3200 yards", target: Time.now)
    expect(one.local_target).to eq(one.target.in_time_zone(ActiveSupport::TimeZone.new("Tokyo")))
  end

  it "gets default current_time_zone_text" do
    expect(Record.current_time_zone_text).to eq("Pacific Time (US & Canada)")
  end

  it "gets correct current_time_zone_text" do
    user = User.create!(email: "whatever@jeff.is", password: "test")
    tz = user.records.create!(raw: "time zone, Tokyo", target: Time.now - 5.minutes)
    one = user.records.create!(raw: "workout, swim, 3200 yards", target: Time.now)
    expect(Record.current_time_zone_text).to eq("Tokyo")
  end

  it "current_time_zone" do

  end

  it "get_cats " do
    user = User.create!(email: "whatever@jeff.is", password: "test")
    one = user.records.create!(raw: "workout, swim", target: Time.now)
    two = user.records.create!(raw: "workout, swim", target: Time.now)

    expect(Record.get_cats('swim').count).to eq(2)
  end

  it "get_cat_count_per_day" do
    # experimental
  end

  it "get_trending_cats" do
    user = User.create!(email: "whatever@jeff.is", password: "test")
    one = user.records.create!(raw: "workout, swim", target: Time.now)
    two = user.records.create!(raw: "restaurant", target: Time.now)
    expect(Record.get_trending_cats(user)).to include("workout")
    expect(Record.get_trending_cats(user)).to include("restaurant")
  end

  it "get_list_of_cat_frequencies" do
  end

  it "cats_from_raw" do
    user = User.create!(email: "whatever@jeff.is", password: "test")
    one = user.records.create!(raw: "workout, swim, 3200 yards", target: Time.now)
    expect(one.cats_from_raw).to eq(['workout', 'swim', '3200 yards'])
  end

  # TODO: test for decimals, weird inputs
  it "cats_from_raw_without_mags" do
    user = User.create!(email: "whatever@jeff.is", password: "test")
    one = user.records.create!(raw: "workout, swim, 3200 yards", target: Time.now)
    expect(one.cats_from_raw_without_mags).to eq(['workout', 'swim', 'yards'])
  end

  it "calculates hue correctly" do
    user = User.create!(email: "whatever@jeff.is", password: "test")
    one = user.records.create!(raw: "workout, swim, 3200 yards", target: Time.now)

    # Do our own arithmetic to check
    minutes = one.target.strftime('%k').to_f * 60.0
    minutes += one.target.strftime('%M').to_f
    test_hue = (minutes / 1440.0) * 360.0

    expect(one.hue).to eq(test_hue)
  end


end
