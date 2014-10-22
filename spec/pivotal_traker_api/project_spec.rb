require 'spec_helper'

describe "Project" do
  before :all do
    @token = "wertyuioppoiuyt"
    @project_id = 99
    @service = PivotalTrackerApi::API.new(@token)
  end
  it "should find every project" do
    projects = File.read "spec/fixtures/projects.json"
    stub_request(:get, "#{API_URL}/projects")
      .with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby', 'X-Trackertoken'=> @token })
      .to_return(:status => 200, :body => projects)
    
    res = @service.projects
    expect(res).to eq(JSON.parse(projects))
  end

  it "should find specific project" do
    project = File.read "spec/fixtures/project.json"
    stub_request(:get, "#{API_URL}/projects/#{@project_id}").to_return(:status => 200, :body => project)

    res = @service.find_project_by_id(@project_id)
    expect(res).to eq(JSON.parse(project)) 
  end
end