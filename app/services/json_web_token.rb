class JsonWebToken
  ALGORITHM = "HS256".freeze

  def self.encode(payload = {}, exp: 24.hours.from_now, **kwargs)
    token_payload = payload.to_h.merge(kwargs).merge(exp: exp.to_i)
    JWT.encode(token_payload, secret_key, ALGORITHM)
  end

  def self.decode(token)
    decoded_payload, = JWT.decode(token, secret_key, true, { algorithm: ALGORITHM })
    decoded_payload.with_indifferent_access
  rescue JWT::DecodeError
    nil
  end

  def self.secret_key
    Rails.application.secret_key_base
  end

  private_class_method :secret_key
end
