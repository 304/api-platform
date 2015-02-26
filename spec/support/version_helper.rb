module VersionHelper

  def get_v1(path, parameters = nil, headers_or_env = {})
    headers_or_env.merge!({'Accept-Version' => 'v1'})
    get path, parameters, headers_or_env
  end

  def post_v1(path, parameters = nil, headers_or_env = {})
    headers_or_env.merge!({'Accept-Version' => 'v1'})
    post path, parameters, headers_or_env
  end

  def signed_get_v1(path, parameters = nil, headers_or_env = {})
    headers_or_env.merge!({'Accept-Version' => 'v1'})
    signed_get path, parameters.merge(headers: headers_or_env)
  end
end