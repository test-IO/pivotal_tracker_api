module PivotalTrackerApi
  module ProjectMembership

    def find_membership_by_project_id(project_id, params={})
      get "/projects/#{project_id}/memberships", params
    end

  end
end
