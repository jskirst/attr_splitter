module AttrSplitter
  class Railtie < Rails::Railtie
    initializer 'attr_splitter.model_additions' do
      ActiveSupport.on_load :active_record do
        extend ModelAdditions
      end
    end
    
    initializer 'attr_splitter.form_builder_additions' do
      ActionView::Helpers::FormBuilder.send :include, FormBuilderAdditions
    end
  end
end