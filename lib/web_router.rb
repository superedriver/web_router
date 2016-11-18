require 'pry'
require 'web_router/version'
require 'rack'
require 'oj'
require 'web_router/version'
require 'web_router/router'
require 'web_router/controller'

module WebRouter
  # App = WebRouter::Application.new
  App = WebRouter::Router.new
end
