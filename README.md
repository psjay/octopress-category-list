Category List for Octopress
=======================

Introduction
------------
Easy output tag cloud and category list.

Usage
------
Just simply put few files as following:

    .
    ├─ plugins/
    │  └── category_list.rb
    └─ source/
       └─ _includes/
          └─ custom/
             └─ asides/
                ├─ category_list.html
                └─ category_cloud.html

Then, you can modify your `_config.yml` file to add category list and/or category cloud tags in your blog's sidebar:

    default_asides: [..., custom/asides/category_list.html, custom/asides/category_cloud.html, ...]

Syntax
-------
If you need to write template files by yourself, these would be useful for you:

    {% category_cloud [counter:true] %}
    {% category_list [counter:true] %}

If `counter` is set to `true`, category list/could tags will show posts count of the corresponding category.

Style
------
You could write custom style for these two components in any available `.scss` file (`sass/custom/_styles.scss` is recommended).

Licence
--------
Distributed under the [MIT License][MIT].

[MIT]: http://www.opensource.org/licenses/mit-license.php
