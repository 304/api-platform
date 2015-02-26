module AuthHelpers
  def authenticate!
    error!({errors: Validation::UNAUTHORIZED}, 401) unless authenticated?
  end

  def authenticated?
    token = current_token
    if TokenValidator.new(token).valid?
      return ApiAuth.authentic?(request, token.signature)
    end
    false
  end

  def current_user
    current_token.user
  end

  def current_token
    access_id = ApiAuth.access_id(request)
    Token.find_by_id(access_id)
  end
end
