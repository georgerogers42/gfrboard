require 'sequel'
require 'pg'

require_relative 'urlparse'

module GBoard
  module Models
    DB = Sequel.connect(ENV["DATABASE_URL"])
    class Board < Sequel::Model
      one_to_many :threads
    end
    class Thread < Sequel::Model
      many_to_one :board
      one_to_many :posts
      include MDContents
    end
    class Post < Sequel::Model
      many_to_one :thread
      include MDContents
    end
  end
end
