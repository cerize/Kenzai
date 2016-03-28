module ApplicationHelper

  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language).div(:line_numbers => :table)
    end
  end


  def markdown(text)
    coderayified = CodeRayify.new(:filter_html => true,
    :hard_wrap => true)

    extensions = {
      strikethrough: true,
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true,
      highlight: true,
      footnotes: true,
    }
    markdown_to_html = Redcarpet::Markdown.new(coderayified, extensions)
    markdown_to_html.render(text).html_safe
  end
  
end
