module Admin::PagesHelper
  
  def pages_for_parent_select(page, options={})
    options.merge({:include_blank=>true})
    ret = []
    ret << [] if options[:include_blank]
    ret = ret | (page.new_record? ? pages_tree(current_site) : pages_tree(current_site, page))
  end
  
  def pages_tree(site, exclude_page=nil)
    ret = []
    q = site.pages
    q = q.where('pages.id!=?', exclude_page.id) unless exclude_page.blank?
    q.roots.shown_on_lists.all.each{ |p| ret |= get_sub_pages(p,0) }
    ret
  end
  
  def get_sub_pages(parent, depth)
    ret = [ ['-'*depth+parent.title, parent.id] ]
    for p in parent.sub_pages.shown_on_lists.all
      ret |= get_sub_pages(p, depth+1)
    end
    ret
  end
  
end
