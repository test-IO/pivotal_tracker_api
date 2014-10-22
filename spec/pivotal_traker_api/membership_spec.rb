require 'spec_helper'

describe "Membership" do
  before :all do
    @token = "wertyuioppoiuyt"
    @project_id = 99
    @service = PivotalTrackerApi::API.new(@token)
  end
  it "should find every membership by project id" do
    memberships = File.read "spec/fixtures/memberships.json"
    stub_request(:get, "#{API_URL}/projects/#{@project_id}/memberships").to_return(:status => 200, :body => memberships)
    
    res = @service.find_membership_by_project_id(@project_id)
    expect(res).to eq(JSON.parse(memberships))

  end

end