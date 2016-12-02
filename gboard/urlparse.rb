require 'redcarpet'

module GBoard
  MD = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(escape_html: true))
end
