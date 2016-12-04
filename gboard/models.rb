require 'digest'
require 'securerandom'
require 'sequel'
require 'pg'

require_relative 'urlparse'

module GBoard
  module Models
    extend self
    DB = Sequel.connect(ENV["DATABASE_URL"])
    class Moderator < Sequel::Model
      def password=(s)
        self.salt = SecureRandom.base64()
        super Digest::SHA256.hexdigest(salt + s)
      end
      def correct_password?(s)
        Digest::SHA256.hexdigest(salt + s) == password
      end
    end
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
