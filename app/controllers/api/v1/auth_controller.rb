module Api
  module V1
    class AuthController < ActionController::API
      def register
        user = User.new(user_params)

        if user.save
          token = JsonWebToken.encode(user_id: user.id)
          render json: auth_response(user, token), status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def login
        email = params[:email].presence || params.dig(:user, :email)
        password = params[:password].presence || params.dig(:user, :password)

        user = User.find_by(email: email.to_s.strip.downcase)

        if user&.authenticate(password.to_s)
          token = JsonWebToken.encode(user_id: user.id)
          render json: auth_response(user, token), status: :ok
        else
          render json: { error: "Email ou senha inválidos" }, status: :unauthorized
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end

      def auth_response(user, token)
        {
          token: token,
          user: {
            id: user.id,
            email: user.email
          }
        }
      end
    end
  end
end
