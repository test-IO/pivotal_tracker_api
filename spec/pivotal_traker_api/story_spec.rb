require 'spec_helper'

describe "Stories" do
  before :all do
    @project_id = 99
    @story_id = 555
    @token = "wertyuioppoiuyt"
    @service = PivotalTrackerApi::API.new(@token)
  end
  it "should find every stories of a project" do
    stories = File.read "spec/fixtures/stories.json"
    stub_request(:get, "#{API_URL}/projects/#{@project_id}/stories").to_return(:status => 200, :body => stories)
    res = @service.find_stories_by_project_id(@project_id)
    expect(res).to eq(JSON.parse(stories))
  end

  it "should find specfic story" do
    story = File.read "spec/fixtures/story.json"
    stub_request(:get, "#{API_URL}/projects/#{@project_id}/stories/#{@story_id}").to_return(:status => 200, :body => story)
    res = @service.find_story_by_project_id_and_id(@project_id, @story_id)
    expect(res).to eq(JSON.parse(story))
  end
  it "should create a story" do
    new_story = File.read "spec/fixtures/new_story.json"
    stub_request(:post, "#{API_URL}/projects/#{@project_id}/stories")
      .with(:body => {"name" => "Exhaust ports are ray shielded"} )
      .to_return(:status => 200, :body => new_story)

    res = @service.create_story(@project_id, :name => "Exhaust ports are ray shielded")
    expect(res).to eq(JSON.parse(new_story))
  end
  it "should raise an error for unvalid story creation" do
    expect { @service.create_story(@project_id, :other_attribute => "wrong") }.to raise_error(PivotalTrackerApi::ArgumentError)
  end
  it "should upload attachment" do
    attachment = File.read "spec/fixtures/attachment.json"
    request_story_update = File.read "spec/fixtures/request_story_update.json"
    story_updated = File.read "spec/fixtures/story_updated.json"
    
    stub_request(:post, "#{API_URL}/projects/#{@project_id}/uploads").to_return(:status => 200, :body => attachment)
    # stub_request(:put, "#{API_URL}/projects/#{@project_id}/stories/#{@story_id}").with(:body => request_story_update).to_return(:status => 200, :body => story_updated)

    stub_request(:post, "https://www.pivotaltracker.com/services/v5/projects/#{@project_id}/stories/#{@story_id}/comments")
      .with(:body => {"text"=>"https://www.pivotaltracker.com/file_attachments/300/download"},
            :headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'Content-Length'=>'77', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Ruby', 'X-Trackertoken'=>@token})
      .to_return(:status => 200, :body => story_updated)
      
    
    res = @service.upload_attachment(@project_id, @story_id, "spec/fixtures/new-imperial-logo-6.jpg")
    expect(res).to eq(JSON.parse(story_updated))
  end
end