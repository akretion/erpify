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


Note that you can also use the OoorPublicModel drop instead (advised key: 'ooor_public_model'
OoorPublicModel doesn't need an Ooor session in its constructor, it will use the session of the Ooor.default_config instead.
So you can use OoorPublicModel for public anonymous access in your website for instance, while objects
requiring a user authentication (with Devise for instance) will use OoorModel instead.
So 'ooor_model' and 'ooor_public_model' are just like the sames from the OOOREST RequestHelper you may use in your Rails application inside your views or controllers. Nothing even prevents you to use the two gems together in the same app.
How cool is that?
