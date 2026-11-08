require 'commonmarker'

module Jekyll
  module Converters
    class Markdown
      class ObsidianCommonmark
        MARKER = "<!-- obsidian-math -->\n".freeze

        def initialize(config)
          @kramdown = KramdownParser.new(config)
        end

        def convert(content)
          return @kramdown.convert(content) unless content.start_with?(MARKER)

          Commonmarker.to_html(content.delete_prefix(MARKER), options: {
            extension: { math_dollars: true, table: true, strikethrough: true, autolink: true, tasklist: true },
            render: { unsafe: true }
          }, plugins: { syntax_highlighter: nil })
        end
      end
    end
  end
end

Jekyll::Hooks.register [:posts, :pages], :pre_render do |document|
  if document.data['math'] && !document.content.start_with?(Jekyll::Converters::Markdown::ObsidianCommonmark::MARKER)
    document.content = Jekyll::Converters::Markdown::ObsidianCommonmark::MARKER + document.content
  end
end
