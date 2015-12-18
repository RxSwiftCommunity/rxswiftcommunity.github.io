require 'lib/custom_helpers'

helpers CustomHelpers

activate :directory_indexes

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
