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
    @layout_template = page.template unless page.template.blank?
    @template = Liquid::Template.parse(@layout_template.content)
    raw @template.render( 'page' => page, 'menu_items'=>@menu_items, 'page_type'=>page.page_type.blank? ? 'page' : page.page_type.slug, 'collections'=>@collections, 'path'=>request.path )
  end

  def generate_html(form_builder, method, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
    options[:partial] ||= method.to_s.singularize
    options[:form_builder_local] ||= :f
    form_builder.fields_for(method, options[:object], :child_index => 'new_'+method.to_s.singularize) do |f|
      render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })
    end
  end

  def generate_template(form_builder, method, options = {})
    escape_javascript generate_html(form_builder, method, options)
  end
end
