module PivotalTrackerApi
  module Project
    
    def projects(params={})
      get '/projects', params
    end

    def find_project_by_id(id, params={})
      get "/projects/#{id}", params
    end
  end
end
