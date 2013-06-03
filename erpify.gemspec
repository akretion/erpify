$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = "erpify"
  s.version = "0.0.1"

  s.date = %q{2013-06-02}
  s.authors = ["Raphael Valyi - www.akretion.com"]
  s.email = %q{raphael.valyi@akretion.com}
  s.summary = %q{Erpify}
  s.homepage = %q{http://github.com/akretion/erpify}
  s.description = %q{OpenERP for your customizable Ruby website. Makes OOOR goodness available in the Liquid non-evaling markup language.}

  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "README.md", "Rakefile"]

  s.add_dependency 'locomotive_liquid',               '> 2.4.0'
  s.add_dependency "ooor"
end
