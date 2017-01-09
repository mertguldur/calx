require 'rails_helper'

describe AppAuthorizationRequest do
  subject do
    create :app_authorization_request,
           user: create(:user),
           tenant: create(:tenant)
  end

  describe '#responses' do
    let(:response) do
      create :app_authorization_response,
             app_authorization_request: subject
    end

    it 'is app authorization responses' do
      expect(subject.responses).to eq(subject.app_authorization_responses)
    end
  end

  describe '#last_response' do
    before do
      create :app_authorization_response,
             created_at: 1.hour.ago,
             id: 1,
             app_authorization_request: subject

      create :app_authorization_response,
             created_at: Time.current,
             id: 2,
             app_authorization_request: subject
    end

    it 'is the most recent response' do
      expect(subject.last_response.id).to eq(2)
    end
  end

  describe '#last_response_type?' do
    let(:response) do
      create :app_authorization_response,
             app_authorization_request: subject
    end

    it 'is the most recent app authorization response type' do
      expect(subject.last_response_type?(response.response_type)).to eq(true)
    end
  end

  describe '#open?' do
    context 'no response' do
      it 'is open' do
        expect(subject).to be_open
      end
    end

    context 'last response is revoke' do
      before do
        create :app_authorization_response,
               app_authorization_request: subject,
               app_authorization_response_type: AppAuthorizationResponseType[:revoke]
      end

      it 'is open' do
        expect(subject).to be_open
      end
    end

    context 'last response is grant' do
      before do
        create :app_authorization_response,
               app_authorization_request: subject,
               app_authorization_response_type: AppAuthorizationResponseType[:grant]
      end

      it 'is not open' do
        expect(subject).to_not be_open
      end
    end
  end

  describe '.requests_for' do
    it 'returns the requests for the user' do
      expect(described_class.requests_for(subject.user_id)).to eq([subject])
    end
  end

  describe '.can_create?' do
    context 'tenant has already requested access' do
      it 'is false' do
        expect(described_class.can_create?(subject.tenant, subject.user_id)).to eq(false)
      end
    end

    context "tenant hasn't requested access yet" do
      let(:another_tenant) { create(:tenant) }

      it 'is true' do
        expect(described_class.can_create?(another_tenant, subject.user_id)).to eq(true)
      end
    end
  end
end
