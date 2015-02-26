module AuthenticationHelper

  def signed_get(path, params = {})
    signed_request(path, :get, params)
  end

  def signed_post(path, object, params = {})
    signed_request(path, :post, params.merge(content: object.to_json))
  end

  def signed_request(path, method, params = {})
    token = params[:token]
    access_id = token.try(:id) || params[:access_id]
    secret_key = token.try(:signature) || params[:secret_key]
    content_type = params[:content_type] || 'application/json'
    headers = params[:headers] || { 'Content-Type' => content_type }
    content = params[:content] || ''

    request = request_object path, method, content, headers
    ApiAuth.sign!(request, access_id, secret_key)

    self.send(method, *[path, content, request_headers(request)])
  end

  private

  def request_object(path, method, content, headers)
    request = "Net::HTTP::#{method.to_s.capitalize}".constantize.new(path, headers)
    request.body = content
    request
  end

  def request_headers(request)
    required = ['content-md5', 'date', 'authorization', 'content-type']
    required.map { |h| [h, request[h]] }.to_h.compact
  end

end