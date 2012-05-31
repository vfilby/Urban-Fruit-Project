Urbanfruitproject::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  
  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
  
  config.indextank_index = 'urbanfruitproject_dev'
  
  Paperclip.options[:command_path] = "/usr/local/ImageMagick/bin/"
  
  # Workless
  config.after_initialize do 
    Delayed::Job.scaler = :null
  end
  
  #Debug needs to be squashed!
  require 'ruby-debug'
  Debugger.settings[:autoeval] = true
  Debugger.settings[:autolist] = 1
  Debugger.settings[:reload_source_on_change] = true
  Debugger.start_remote
  puts "=> Debugger enabled"
end

