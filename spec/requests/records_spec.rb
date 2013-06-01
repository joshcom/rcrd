require 'spec_helper'

describe "Records" do
  describe "GET /records" do
    it "loads records_path" do
      get records_path
      response.status.should be(200)
    end
    it "loads a record" do
      one = Record.create!(raw: "workout, swim")
      get record_path one
      response.status.should be(200)
    end
  end
end