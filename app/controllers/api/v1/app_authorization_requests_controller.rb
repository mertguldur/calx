module Api
  module V1
    class AppAuthorizationRequestsController < Api::V1::ApplicationController
      def create
        user = User.find_by_api_id(params[:user_id])
        unless user
          render json: { errors: [{ title: "User doesn't exist" }] },
            status: :unprocessable_entity
          return
        end

        unless AppAuthorizationRequest.can_create?(@tenant, user)
          render json: { errors: [{ title: "Client can't be authorized for this user" }] },
            status: :unprocessable_entity
          return
        end

        created_request = AppAuthorizationRequest.create!(tenant_id: @tenant.id, user_id: user.id)
        render json: AppAuthorizationRequestPresenter.new(created_request), status: :created
      end
    end
  end
end
