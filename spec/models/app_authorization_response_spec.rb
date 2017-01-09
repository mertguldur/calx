require 'rails_helper'

describe AppAuthorizationResponse do
  subject { create(:app_authorization_response) }

  describe '#response_type' do
    it 'is app_authorization_response_type' do
      expect(subject.response_type).to eq(subject.app_authorization_response_type)
    end
  end
end
