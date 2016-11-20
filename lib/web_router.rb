require 'rack'
require 'oj'
require 'erb'
require 'web_router/version'
require 'web_router/router'
require 'web_router/controller'

module WebRouter
  App = WebRouter::Router.new
end
