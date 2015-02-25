module ResponseHelper

  def error_response(errors, error_code = 400)
    expect(response.status).to eq(error_code)
    expect(response.body).to eq({errors: errors}.to_json)
  end

end