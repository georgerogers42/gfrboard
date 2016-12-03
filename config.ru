require 'rack/auth'
require_relative 'gboard/app'

mount '/del/' do
  use Rack::Auth::Basic, "moderation" do |username, password|
    moderator = GBoard::Models::Moderator.find(name: username)
    moderator.correct_password?(password)
  end
  run GBoard::ModApp
end

run GBoard::App
