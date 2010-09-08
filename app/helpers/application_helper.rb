module ApplicationHelper

  class GroovyContentFileSystem

    def initialize(site)
      @site = site
    end

    def read_template_file(template_path)
      t = @site.templates.find_by_name!(template_path)
      t.content
    end
  end
  def generate_content_for_page(page)
    Liquid::Template.file_system = GroovyContentFileSystem.new(current_site)
    @template = Liquid::Template.parse(@page_template.content)
    raw @template.render( 'page' => page )
  end
end
