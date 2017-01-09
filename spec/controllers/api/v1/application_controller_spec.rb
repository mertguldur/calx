require 'rails_helper'

describe Api::V1::ApplicationController do
  controller do
    def index
      head(:ok)
    end
  end

  context 'tenant authentication' do
    let!(:tenant) { create :tenant, access_id: 'foo' }

    context 'tenant is authenticated' do
      before do
        allow(ApiAuth).to receive(:access_id) { 'foo' }
        allow(ApiAuth).to receive(:authentic?) { true }
      end

      it 'is 200' do
        get :index
        expect(response.status).to eq(200)
      end
    end

    context "tenant is missing" do
      before do
        allow(ApiAuth).to receive(:access_id) { 'bar' }
      end

      it 'is 401' do
        get :index
        expect(response.status).to eq(401)
      end
    end

    context "tenant is not authenticated" do
      before do
        allow(ApiAuth).to receive(:access_id) { 'foo' }
        allow(ApiAuth).to receive(:authentic?) { false }
      end

      it 'is 401' do
        get :index
        expect(response.status).to eq(401)
      end
    end
  end
end
