erpify
======

example usage:

```ruby
require 'erpify'

url = 'http://localhost:8069/xmlrpc'
username = 'admin'
password = 'admin'
database = 'mydatabase'
Ooor.default_config = {url: url, username: username, password: password, database: database}

template = <<-eos
this is an example of a Liquid template
{% with_domain type:'service' %}
{% for product in ooor['product.product'] %}
{{product.name}} - {{product.categ_id.name}}
{% endfor %}
{% endwith_domain %}
the end!
eos

@template = Liquid::Template.parse(template) # Parses and compiles the template
puts @template.render("ooor" => Erpify::Liquid::Drops::Ooor.new)
```
