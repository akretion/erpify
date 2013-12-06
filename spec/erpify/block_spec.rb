require 'spec_helper'

describe Erpify::Liquid::Tags::WithDomain do

  it 'decodes basic options (boolean, integer, ...)' do
    scope   = Erpify::Liquid::Tags::WithDomain.new('with_domain', "active: true, price: 42, title: 'foo', hidden: false", ["{% endwith_domain %}"], {})
    options = decode_options(scope)
    options['active'].should == true
    options['price'].should == 42
    options['title'].should == 'foo'
    options['hidden'].should == false
  end

  it 'decodes regexps' do
    scope   = Erpify::Liquid::Tags::WithDomain.new('with_domain', 'title: /Like this one|or this one/', ["{% endwith_domain %}"], {})
    options = decode_options(scope)
    options[:title].should == /Like this one|or this one/
  end

  it 'decodes context variable' do
    scope   = Erpify::Liquid::Tags::WithDomain.new('with_domain', 'category: params.type', ["{% endwith_domain %}"], {})
    options = decode_options(scope, { 'params' => { 'type' => 'posts' } })
    options[:category].should == 'posts'
  end

  it 'allows order_by option' do
    scope   = Erpify::Liquid::Tags::WithDomain.new('with_domain', 'order_by:\'name DESC\'', ["{% endwith_domain %}"], {})
    options = decode_options(scope)
    options['order_by'].should == 'name DESC'
  end

  it 'stores attributes in the context' do
    template  = ::Liquid::Template.parse("{% with_domain active:true, title:'foo' %}{{ with_domain.active }}-{{ with_domain.title }}{% endwith_domain %}")
    text      = template.render
    text.should == 'true-foo'
  end

  it 'allows a variable condition inside a loop' do
    template  = ::Liquid::Template.parse("{%for i in (1..3)%}{% with_domain number: i %}{{ with_domain.number}}{% endwith_domain %}{%endfor%}")

    text      = template.render
    text.should == '123'
  end

  it 'replaces _permalink by _slug' do
    template  = ::Liquid::Template.parse("{% with_domain _permalink: 'foo' %}{{ with_domain._slug }}{% endwith_domain %}")
    text      = template.render
    text.should == 'foo'
  end

#  describe "advanced queries thanks to h4s" do

#    it 'decodes criteria with gt and lt' do
#      scope   = Erpify::Liquid::Tags::WithDomain.new('with_domain', 'price.gt:42.0, price.lt:50', ["{% endwith_domain %}"], {})
#      options = decode_options(scope)
#      options[:price.gt].should == 42.0
#      options[:price.lt].should == 50
#    end

#  end

  def decode_options(tag, assigns = {})
    context   = ::Liquid::Context.new(assigns)
    arguments = tag.instance_variable_get(:@arguments)
    tag.send(:decode, *arguments.interpolate(context))
  end

end
