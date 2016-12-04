require 'rack/auth'
require_relative 'gfrboard/app'

map '/del/' do
  use Rack::Auth::Basic, "moderation" do |username, password|
    moderator = GfrBoard::Models::Moderator.find(name: username)
    moderator.correct_password?(password) if moderator
  end
  run GfrBoard::ModApp
end

run GfrBoard::App
