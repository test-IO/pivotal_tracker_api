require 'rest_client'
require 'net/http/post/multipart'
require "pivotal_tracker_api/version"
require "pivotal_tracker_api/project_membership"
require "pivotal_tracker_api/project"
require "pivotal_tracker_api/story"

module PivotalTrackerApi
  class ArgumentError < Exception; end
  class NotFound < Exception; end
  class ApiError < Exception; end
  class API
    include PivotalTrackerApi::Story
    include PivotalTrackerApi::Project
    include PivotalTrackerApi::ProjectMembership
    DOMAIN_URL = "https://www.pivotaltracker.com"
    API_URL = "https://www.pivotaltracker.com/services/v5"
    
    attr_accessor :token
    
    def initialize(token_api, params={})
      @token= token_api
    end

    def get(path, params={})
      parse_response service[path].get(params)
    end

    def put(path, params={} )
      parse_response service[path].put(params)
    end

    def post(path, params={}, headers={})
      parse_response service[path].post(params, headers)
    end

    def upload(path, filename)
      url = URI.parse(API_URL+path)
      req = Net::HTTP::Post::Multipart.new( url.path, "file" => UploadIO.new(filename, "multipart/form-data"))
      http = Net::HTTP.new(url.host, url.port)
      req["X-TrackerToken"] = @token
      # to debug
      # http.set_debug_output($stderr)
      
      if url.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      response = http.request(req)
      parse_response response
    end

    def delete(path, params={})
      parse_response service[path].delete
    end
    protected
    def parse_response(response)
      case response.code.to_i
      when 200, 201
        JSON.parse(response.body)
      when 404
        raise NotFound.new(response)
      else
        raise ApiError.new(response)
      end
    end
    def service
      return @service if @service
      @service = ::RestClient::Resource.new(API_URL, :headers => {'X-TrackerToken' => @token} )
    end
  end
end
