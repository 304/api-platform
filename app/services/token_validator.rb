class TokenValidator
  def initialize(token)
    @token = token
  end

  def valid?
    !(nil? || expired? || old?)
  end

  def nil?
    @token.nil?
  end

  def expired?
    Time.current > @token.expired_at
  end

  def old?
    user = @token.user
    last_token = Token.last_token_for(user)
    last_token != @token
  end
end