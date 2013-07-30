require 'attr_splitter'
require 'supermodel'
require 'active_support'
require 'action_pack'
require 'action_view'
require 'action_controller'
require 'action_dispatch'

ActionView::Helpers::FormBuilder.send :include, AttrSplitter::FormBuilderAdditions