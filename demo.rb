# Bundler setup
require "rubygems"
require "bundler/setup"

# Autoload from current directory
require "active_support/dependencies"
ActiveSupport::Dependencies.autoload_paths << File.expand_path(File.dirname(__FILE__))

# Simple case: load class within first folder
#   #<Blog::Post:0x00000101a6eaa8 @title="Test">
puts Blog::Post.new.inspect

# Another simple case: load nested class within folders
#   #<Blog::Post:0x00000101a63ba8 @title="Test">
puts Blog::Admin::PostsController.hardcoded.inspect

# It gets complicated: attempts to load Blog::Admin::Post (similar to inherited_resources)
# We would expect either a NameError or have it return Blog::Post. Instead we get:
#   /Users/sam/.rvm/gems/ruby-1.9.2-p180/bundler/gems/rails-12786518f1f7/
#      activesupport/lib/active_support/dependencies.rb:476:in `load_missing_constant':
#      Blog is not missing constant Post! (ArgumentError)
puts Blog::Admin::PostsController.autodetect.inspect

# Interestingly, this last line works if we run it first (before Blog::Post is loaded)
# but then fails if we run it again (since Blog::Post is now loaded).
