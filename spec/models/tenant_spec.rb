require 'rails_helper'

describe Tenant do
  subject { create(:tenant) }

  it 'persists a secret key' do
    expect(subject.secret_key).to be_present
  end

  it 'validates the presence of access id' do
    tenant = build(:tenant, access_id: nil)
    expect(tenant.save).to eq(false)
    expect(tenant.errors.full_messages.first).to eq("Access can't be blank")
  end

  describe 'access_to_user?' do
    let(:user) { create(:user) }

    context 'no request' do
      it 'is false' do
        expect(subject.access_to_user?(user.api_id)).to eq(false)
      end
    end

    context 'request has been made' do
      let!(:request) do
        create :app_authorization_request,
               tenant: subject,
               user: user
      end

      before do
        response_order.each do |response_type|
          create :app_authorization_response,
                 app_authorization_request: request,
                 app_authorization_response_type: AppAuthorizationResponseType[response_type]
        end
      end

      context 'no response' do
        let(:response_order) { [] }

        it 'is false' do
          expect(subject.access_to_user?(user.api_id)).to eq(false)
        end
      end

      context 'the only response is grant' do
        let(:response_order) { %i(grant) }

        it 'is true' do
          expect(subject.access_to_user?(user.api_id)).to eq(true)
        end
      end

      context 'last response is revoke' do
        let(:response_order) { %i(grant revoke) }

        it 'is false' do
          expect(subject.access_to_user?(user.api_id)).to eq(false)
        end
      end

      context 'last response is grant' do
        let(:response_order) { %i(grant revoke grant) }

        it 'is true' do
          expect(subject.access_to_user?(user.api_id)).to eq(true)
        end
      end
    end
  end
end
