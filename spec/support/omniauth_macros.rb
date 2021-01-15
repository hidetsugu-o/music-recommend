module OmniauthMacros
  def line_mock
    OmniAuth.config.mock_auth[:line] = OmniAuth::AuthHash.new(
      {
        provider: 'line',
        uid: "#{Faker::Internet.password(min_length: 20)}1a",
        info: {
          name: Faker::Name.name,
          icon: Faker::Internet.url,
          description: Faker::Music.instrument
        },
        credentials: {
          token: 'hogehuga'
        }
      }
    )
  end
end
