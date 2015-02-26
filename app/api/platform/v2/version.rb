module Platform
  module V2
    class Version < Grape::API
      desc 'Returns version'
      resource :version do
        get do
          { version: 'v2' }
        end
      end
    end
  end
end