require 'attr_splitter'
require 'supermodel'
require 'active_support'
require 'action_pack'
require 'action_view'
require 'action_controller'
require 'action_dispatch'

module FakeHelpersModule
end

module AttrSplitterSpecHelper
  include ActionPack
  include ActionView::Context if defined?(ActionView::Context)
  include ActionController::RecordIdentifier if defined?(ActionController::RecordIdentifier)
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::ActiveRecordHelper if defined?(ActionView::Helpers::ActiveRecordHelper)
  include ActionView::Helpers::ActiveModelHelper if defined?(ActionView::Helpers::ActiveModelHelper)
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::AssetTagHelper
  include ActiveSupport
  include ActionController::PolymorphicRoutes if defined?(ActionController::PolymorphicRoutes)
  include ActionDispatch::Routing::PolymorphicRoutes 
  include AbstractController::UrlFor if defined?(AbstractController::UrlFor)
  include ActionView::RecordIdentifier if defined?(ActionView::RecordIdentifier)
  
  include AttrSplitter::FormBuilderAdditions
  
  def self.included(base)
    base.class_eval do
      attr_accessor :output_buffer
      def protect_against_forgery?; false; end
      def _helpers
        FakeHelpersModule
      end
    end
  end
end
# 
# # Mocking forms will fail unless we override this
# def protect_against_forgery?
# end