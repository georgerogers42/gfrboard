require 'slim'
require 'sinatra/base'

require_relative 'models'

module GBoard
  class App < Sinatra::Base
    get '/' do
      @boards = Models::Board.all
      slim :index
    end
    get '/b/:board' do |board|
      @board = Models::Board.find(name: board)
      slim :board
    end
    get '/t/:thread' do |thread|
      @thread = Models::Thread.find(id: thread.to_i)
      slim :thread
    end
    post '/b/:board' do |name|
      board = Models::Board.find(name: name)
      thread = Models::Thread.create(board_id: board.id, title: params[:title], contents: params[:contents])
      redirect "/t/#{thread.id}"
    end
    post '/t/:thread' do |thread|
      Models::Post.create(thread_id: thread.to_i, contents: params[:contents])
      redirect "/t/#{thread}"
    end
  end
end
