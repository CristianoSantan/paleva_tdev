Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Você pode substituir '*' por domínios específicos como 'http://127.0.0.1:5500'
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end