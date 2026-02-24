module Api
  module V1
    class BaseController < ActionController::API
      include ActionController::Cookies

      before_action :authenticate_request!

      attr_reader :current_user

      private

      def authenticate_request!
        token = bearer_token
        payload = JsonWebToken.decode(token)

        return render_unauthorized if payload.blank?

        @current_user = User.find_by(id: payload[:user_id])
        render_unauthorized if @current_user.blank?
      end

      def bearer_token
        auth_header = request.headers["Authorization"].to_s
        header_token = auth_header.split(" ").last if auth_header.start_with?("Bearer ")
        header_token.presence || cookies[:jwt]
      end

      def render_unauthorized
        render json: { error: "Não autorizado" }, status: :unauthorized
      end
    end
  end
end
