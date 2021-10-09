# frozen_string_literal: true

require './lib/toggl'

RSpec.describe Toggl do
  describe '#summary' do
    subject do
      toggl = described_class.new(token: 'token', workspace_id: 12345678)
      toggl.summary(since: '2021-01-01', until: '2021-05-31')
    end

    before do
      stub_request(:get, %r{https://api.track.toggl.com/reports/api/v2/summary\?since=2021-01-01&until=2021-05-31.*&workspace_id=12345678})
        .with(headers: { 'Authorization' => 'Basic dG9rZW46YXBpX3Rva2Vu' })
        .to_return(status: 200, body: File.read('spec/support/fixtures/toggl_summary_response.json'))
    end

    it { is_expected.to include({ total_grand: 626591842 }) }
  end
end
