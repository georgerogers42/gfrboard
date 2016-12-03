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
      author = params[:author]
      board = Models::Board.find(name: name)
      if author != ""
        thread = Models::Thread.create(board_id: board.id, title: params[:title], contents: params[:contents], author: author)
      else
        thread = Models::Thread.create(board_id: board.id, title: params[:title], contents: params[:contents])
      end
      redirect "/t/#{thread.id}", 302
    end
    post '/t/:thread' do |thread|
      author = params[:author]
      if author != ""
        Models::Post.create(thread_id: thread.to_i, contents: params[:contents], author: author)
      else
        Models::Post.create(thread_id: thread.to_i, contents: params[:contents], )
      end
      redirect "/t/#{thread}", 302
    end
    post '/del/t/:thread' do |thread|
      t = Models::Thread.find(id: thread.to_i)
      t.delete
      redirect "/b/#{t.board.name}"
    end
    post '/del/p/:post' do |post|
      p = Models::Post.find(id: post.to_i)
      p.delete
      redirect "/t/#{p.thread.id}"
    end
  end
end
