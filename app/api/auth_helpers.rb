module AuthHelpers
  def authenticate!
    error!({errors: Validation::UNAUTHORIZED}, 401) unless authenticated?
  end

  def authenticated?
    token = current_token
    if token
      return false if token.expired?
      return false unless current_user.token_latest?(token)
      return ApiAuth.authentic?(request, token.signature) if token
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
