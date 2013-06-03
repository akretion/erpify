erpify
======

example usage:

```ruby
require 'liquid'
require 'ooor'
require 'erpify'

url = 'http://localhost:8069/xmlrpc'
username = 'admin'
password = 'admin'
database = 'mydatabase'
Ooor.default_config = {url: url, username: username, password: password, database: database}

template = <<-eos
this is an example of a Liquid template
now we find some products in OpenERP {% erp_find products = object: 'product.product', domain:"[]" %}
now let's show them:
{% for p in products %}
{{p.name}}
{% endfor %}
the end!
eos

@template = Liquid::Template.parse(template) # Parses and compiles the template
puts @template.render
```
