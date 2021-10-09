# frozen_string_literal: true

require 'base64'
require 'faraday'
require 'json'

class Toggl
  API_ENDPOINT = 'https://api.track.toggl.com/reports/api/v2'
  USER_AGENT = 'toggl-to-pixela-cloud-functions (https://github.com/ytkg/toggl-to-pixela-cloud-functions)'

  attr_reader :token, :workspace_id

  def initialize(token:, workspace_id:)
    @token = token
    @workspace_id = workspace_id
  end

  def summary(params = {})
    url = "#{API_ENDPOINT}/summary"
    headers = { 'Authorization' => "Basic #{Base64.encode64("#{token}:api_token")}" }
    response = Faraday.get(url, params.merge({ user_agent: USER_AGENT, workspace_id: workspace_id }), headers)
    JSON.parse(response.body, symbolize_names: true)
  end
end
