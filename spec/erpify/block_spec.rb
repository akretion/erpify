require 'spec_helper'

describe Erpify::Liquid::Tags::WithDomain do

  describe '#display' do

    let(:tokens) { ["dummy", "{% enddummy %}", "outside"] }

    subject{ Erpify::Liquid::Tags::WithDomain.new('dummy', 'condition', tokens, {}) }

    it 'yielding should render the block content' do
      subject.render(Liquid::Context.new('condition' => true)).should be == 'dummy'
    end

    it 'should only render until the {% endblock %} tag' do
      subject.render(Liquid::Context.new('condition' => true)).should_not include('outside')
    end

#    it 'should not render its content if it do not yield' do
#      subject.render(Liquid::Context.new('condition' => false)).should_not include('dummy')
#    end

  end

end
