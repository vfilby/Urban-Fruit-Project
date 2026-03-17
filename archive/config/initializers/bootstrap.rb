# from: https://gist.github.com/1829710
require 'bootstrap_form_builder'

# Make this the default Form Builder. You can delete this if you don't want form_for to use
# the bootstrap form builder by default
ActionView::Base.default_form_builder = BootstrapFormBuilder::FormBuilder

# Add in our FormHelper methods, so you can use bootstrap_form_for. 
ActionView::Base.send :include, BootstrapFormBuilder::FormHelper

### Only use one of these error handling methods ###

# Get rid of the rails error handling completely.
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  "#{html_tag}".html_safe
end