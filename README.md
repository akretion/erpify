erpify
======

example usage:

```ruby
require 'erpify'

template = <<-eos
this is an example of a Liquid template
{% with_domain type:'service' %}
{% for product in ooor_model['product.product'] %}
{{product.name}} - {{product.categ_id.name}}
{% endfor %}
{% endwith_domain %}
the end!
eos

@template = Liquid::Template.parse(template) # Parses and compiles the template

url = 'http://localhost:8069/xmlrpc'
username = 'admin'
password = 'admin'
database = 'mydatabase'
session = Ooor.new(url: url, username: username, password: password, database: database)

puts @template.render("ooor_model" => Erpify::Liquid::Drops::OoorModel.new(session))
```


Note that you can typically put a per user session in the 'ooor_model' drop (with a Devise mapping for instance) and a global
public session instead in an other drop called 'ooor_public_model' so you maximize the cache usage for data that
is not user specific.
So 'ooor_model' and 'ooor_public_model' are just the sames concepts as in the OOOREST RequestHelper you may use in your Rails application inside your views or controllers. Nothing even prevents you to use the two gems together in the same app.
How cool is that?
