require_relative 'gboard/app'

mount '/del/' do
  use Rack::Auth::Basic, "moderation" do |username, password|
  end
  run GBoard::ModApp
end

run GBoard::App
