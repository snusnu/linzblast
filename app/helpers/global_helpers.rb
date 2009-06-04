module Merb
  module GlobalHelpers
    # helpers defined here available to all views.  

    def style_links(resource)
      resource.styles.map { |s| link_to(s.name, resource(:admin, s)) }.join(',')
    end

  end
end
