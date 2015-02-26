module Platform
  class ApiV2 < Grape::API
    version 'v2', using: :accept_version_header

    mount Platform::V2::Version
  end
end