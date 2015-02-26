module Platform
  class ApiV1 < Grape::API
    version 'v1', using: :accept_version_header

    mount Platform::V1::Ping
    mount Platform::V1::Tokens
    mount Platform::V1::Users
    mount Platform::V1::Version
  end
end