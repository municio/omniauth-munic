require 'spec_helper'

RSpec.describe OmniAuth::Strategies::Munic do
  let(:access_token) { double('AccessToken', options: {}) }
  let(:response) { double('Response') }
  let(:app) { lambda { |r| [200, '', ['Yo']] } }

  subject { described_class.new(app) }

  before do
    OmniAuth.config.test_mode = true
    allow(subject).to receive(:access_token) { access_token }
  end

   context 'provider name' do
    it { expect(subject.options.name).to eq('munic') }
  end

  context 'client options' do
    it { expect(subject.options.client_options.site).to eq('https://connect.munic.io') }
  end


  context 'auth params' do
    let(:response_params) {
      {
        'uid' => 'fd907347-67c9-4c0c-9452-bffc1d06a4af',
        'full_name' => 'Robert Tulali',
        'email' => 'robert.tulali@yoyo.com',
        'language' => 'english',
        'organization_id' => 5
      }
    }

    before do
      allow(access_token).to receive(:get) { response }
      allow(response).to receive(:parsed) { response_params }
      @raw_info = subject.raw_info
    end

    describe '#raw_info' do
      it { expect(access_token).to have_received(:get).with('/api/v1/users/me.json') }
      it { expect(@raw_info).to eq response_params }
    end

    context 'returns the uid' do
      it { expect(subject.uid).to eq(response_params['uid']) }
    end

    context 'info hash' do
      context 'with limited info' do
        let(:info) {
          {
            email: response_params['email'],
            full_name: response_params['full_name'],
            language: response_params['language'],
            organization_id: response_params['organization_id']
          }
        }

        it { expect(subject.info).to eq(info) }
      end

      context 'with full info' do
        let(:response_params) {
          {
            'uid' => 'fd907347-67c9-4c0c-9452-bffc1d06a4af',
            'full_name' => 'Robert Tulali',
            'email' => 'robert.tulali@yoyo.com',
            'language' => 'english',
            'organization_id' => 5,
            'company_name' => 'Roberto Compnay',
            'time_zone' => 'London'
          }
        }
        let(:info) {
          {
            email: response_params['email'],
            full_name: response_params['full_name'],
            language: response_params['language'],
            company_name: response_params['company_name'],
            organization_id: response_params['organization_id'],
            time_zone: response_params['time_zone']
          }
        }

        before do
          allow(access_token).to receive(:get) { response }
          allow(response).to receive(:parsed) { response_params }
          subject.raw_info
        end

        it { expect(subject.info).to eq(info) }
      end
    end
  end
end
