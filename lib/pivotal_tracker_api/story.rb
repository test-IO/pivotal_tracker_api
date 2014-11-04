module PivotalTrackerApi
  module Story
    
    def find_stories_by_project_id(project_id, params={})
      get "/projects/#{project_id}/stories"
    end
    
    def find_story_by_project_id_and_id(project_id, id, params={})
      get "/projects/#{project_id}/stories/#{id}" 
    end
    
    def upload_attachment(project_id, id, filename, params={})
      raise ArgumentError.new(":project_id is required") unless project_id
      raise ArgumentError.new(":id is required") unless id
      raise ArgumentError.new(":filename is required") unless filename
      attachment = create_attachment project_id, filename
      upload_url = "https://www.pivotaltracker.com#{attachment['download_url']}"
      create_comment project_id, id, "text" => upload_url
    end
    def update_story(project_id, id, params)
      put "/projects/#{project_id}/stories/#{id}", params
    end
    def create_comment(project_id, story_id, params={})
      post "/projects/#{project_id}/stories/#{story_id}/comments", params
    end
    def create_story(project_id, params={})
      raise ArgumentError.new(":name is required") if params[:name].nil?
      post "/projects/#{project_id}/stories", params
    end
    def create_attachment(project_id, filename)
      upload "/projects/#{project_id}/uploads", File.new(filename)
    end
  end
end
