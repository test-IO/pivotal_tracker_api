require 'spec_helper'

describe "Comment"  do
  before :all do
    @token = "wertyuioppoiuyt"
    @project_id = 99
    @story_id = 555
    @service = PivotalTrackerApi::API.new(@token)
  end
  it "should create comment on story" do
    comment = File.read "spec/fixtures/comment.json"
    stub_request(:post, "#{API_URL}/projects/#{@project_id}/stories/#{@story_id}/comments").to_return(:status => 200, :body => comment)

    res = @service.create_comment(@project_id, @story_id, :text => "If this is a consular ship, then where is the ambassador?")
    expect(res).to eq(JSON.parse(comment))
  end
end