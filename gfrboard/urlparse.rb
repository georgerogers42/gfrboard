require 'redcarpet'

module GfrBoard
  MD = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(escape_html: true))
  module MDContents
    def md_contents
      MD.render contents
    end
  end
end
