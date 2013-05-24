# Tag Cloud for Octopress, modified by pf_miles, for use with utf-8 encoded blogs(all regexp added 'u' option).
# modified by alswl, tag_cloud -> category_cloud
# modified by psjay, fixed wrong category url bug.
#
# Category List for Octopress
# =======================
# 
# Introduction
# ------------
# Easy output category cloud and category list.
# 
# Usage
# ------
# Just simply put few files as following:
# 
#     .
#     ├─ plugins/
#     │  └── category_list.rb
#     └─ source/
#        └─ _includes/
#           └─ custom/
#              └─ asides/
#                 ├─ category_list.html
#                 └─ category_cloud.html
# 
# Then, you can modify your `_config.yml` file to add category list and/or category cloud tags in your blog sidebar:
# 
#     default_asides: [..., custom/asides/category_list.html, custom/asides/category_cloud.html, ...]
# 
# Syntax
# -------
# If you need to write template files by yourself, these would be useful for you:
# 
#     {% category_cloud [counter:true] %}
#     {% category_list [counter:true] %}
# 
# If `counter` is set to `true`, category list/could tags will show posts count of the corresponding category.
# 
# Style
# ------
# You could write custom style for these two components in any available `.scss` file (`sass/custom/_styles.scss` is recommended).
# 
# Licence
# --------
# Distributed under the [MIT License][MIT].
# 
# [MIT]: http://www.opensource.org/licenses/mit-license.php


module Jekyll

  class CategoryCloud < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      @opts = {}
      if markup.strip =~ /\s*counter:(\w+)/iu
        @opts['counter'] = ($1 == 'true')
        markup = markup.strip.sub(/counter:\w+/iu,'')
      end
      super
    end

    def render(context)
      lists = {}
      max, min = 1, 1
      config = context.registers[:site].config
      category_dir = config['root'] + config['category_dir'] + '/'
      categories = context.registers[:site].categories
      categories.keys.sort_by{ |str| str.downcase }.each do |category|
        count = categories[category].count
        lists[category] = count
        max = count if count > max
      end

      html = ''
      lists.each do | category, counter |
        url = category_dir + category.to_url
        style = "font-size: #{100 + (60 * Float(counter)/max)}%"
        html << "<a href='#{url}' style='#{style}'>#{category}"
        if @opts['counter']
          html << "(#{categories[category].count})"
        end
        html << "</a> "
      end
      html
    end
  end

  class CategoryList < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      @opts = {}
      if markup.strip =~ /\s*counter:(\w+)/iu
        @opts['counter'] = ($1 == 'true')
        markup = markup.strip.sub(/counter:\w+/iu,'')
      end
      super
    end

    def render(context)
      html = ""
      config = context.registers[:site].config
      category_dir = config['root'] + config['category_dir'] + '/'
      categories = context.registers[:site].categories
      categories.keys.sort_by{ |str| str.downcase }.each do |category|
        url = category_dir + category.to_url
        html << "<li><a href='#{url}'>#{category}"
        if @opts['counter']
          html << " (#{categories[category].count})"
        end
        html << "</a></li>"
      end
      html
    end
  end

end

Liquid::Template.register_tag('category_cloud', Jekyll::CategoryCloud)
Liquid::Template.register_tag('category_list', Jekyll::CategoryList)
