module Api
    module V1
    class SessionsController < BaseController
  skip_before_action :authenticate_request!, only: [:new, :create]

      def index
      end

      def new
        # apenas renderiza o formulário de login
      end

      def create
        email = session_params[:email].to_s.strip.downcase
        @user = User.find_by(email: email)

        if @user&.authenticate(session_params[:password].to_s)
          token = JsonWebToken.encode(user_id: @user.id)

          cookies[:jwt] = {
            value: token,
            httponly: true,
            secure: Rails.env.production?,
            same_site: :strict,
            expires: 24.hours.from_now
          }

          # Redireciona para sessions_path
          redirect_to root_path, notice: "Login confirmado!"
        else
          flash.now[:alert] = "Credenciais inválidas"
          render :new, status: :unprocessable_entity
        end
      end

      private

      def session_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end