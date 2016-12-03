require 'rack/auth'
require_relative 'gboard/app'

map '/del/' do
  use Rack::Auth::Basic, "moderation" do |username, password|
    moderator = GBoard::Models::Moderator.find(name: username)
    moderator.correct_password?(password) if moderator
  end
  run GBoard::ModApp
end

run GBoard::App
