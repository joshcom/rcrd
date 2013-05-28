require "spec_helper"

describe Record do
  it "get_cats " do
    one = Record.create!(raw: "workout, swim")
    two = Record.create!(raw: "workout, swim")

    expect(Record.get_cats('swim').count).to eq(2)
  end

  it "cats_from_raw" do
    one = Record.create!(raw: "workout, swim, 3200 yards")
    expect(one.cats_from_raw).to eq(['workout', 'swim', '3200 yards'])
  end

  # TODO: test for decimals, weird inputs
  it "cats_from_raw_without_mags" do
    one = Record.create!(raw: "workout, swim, 3200 yards")
    expect(one.cats_from_raw_without_mags).to eq(['workout', 'swim', 'yards'])
  end

  it "calculates hue" do
    one = Record.create!(raw: "workout, swim, 3200 yards")

    minutes = one.created_at.strftime('%k').to_f * 60.0
    minutes += one.created_at.strftime('%M').to_f
    test_hue = (minutes / 1440.0) * 360.0

    expect(one.hue).to eq(test_hue)
  end
end
