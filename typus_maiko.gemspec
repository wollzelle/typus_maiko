# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "maiko/version"

Gem::Specification.new do |s|
  s.name        = "typus_maiko"
  s.version     = Typus::Maiko::VERSION
  s.authors     = ["Thomas Koenig", "William Meleyal"]
  s.email       = "team@wollzelle.com"
  s.homepage    = "http://www.maikoapp.com"
  s.summary     = "Maiko module for Typus"
  s.description = "Adds support for including media from Maiko"

  s.rubyforge_project = "typus_maiko"

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency "rails", ">= 3.1.0"
  s.add_dependency "typus"
  s.add_dependency "coffee-rails", ">= 3.1.0"
  s.add_dependency "jquery-rails"
  s.add_dependency "backbone-on-rails"
  s.add_dependency "eco"
end