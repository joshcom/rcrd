require "spec_helper"

describe Record do

  it "get_cats " do
    one = Record.create!(raw: "workout, swim", target: Time.now)
    two = Record.create!(raw: "workout, swim", target: Time.now)

    expect(Record.get_cats('swim').count).to eq(2)
  end

  it "cats_from_raw" do
    one = Record.create!(raw: "workout, swim, 3200 yards", target: Time.now)
    expect(one.cats_from_raw).to eq(['workout', 'swim', '3200 yards'])
  end

  # TODO: test for decimals, weird inputs
  it "cats_from_raw_without_mags" do
    one = Record.create!(raw: "workout, swim, 3200 yards", target: Time.now)
    expect(one.cats_from_raw_without_mags).to eq(['workout', 'swim', 'yards'])
  end

  it "calculates hue correctly" do
    one = Record.create!(raw: "workout, swim, 3200 yards", target: Time.now)

    # Do our own arithmetic to check
    minutes = one.target.strftime('%k').to_f * 60.0
    minutes += one.target.strftime('%M').to_f
    test_hue = (minutes / 1440.0) * 360.0

    expect(one.hue).to eq(test_hue)
  end

  it "gets the default time_zone_text" do
    one = Record.create!(raw: "workout, swim, 3200 yards", target: Time.now)
    expect(one.time_zone_text).to eq("Pacific Time (US & Canada)")
  end

  it "gets the correct time_zone_text" do
    tz = Record.create!(raw: "time zone, Tokyo", target: Time.now - 5.minutes)
    one = Record.create!(raw: "workout, swim, 3200 yards", target: Time.now)
    expect(one.time_zone_text).to eq("Tokyo")
  end

end
