module AttrSplitter
  module ModelAdditions
    def attr_splitter(attribute, args)
      placement = args.include?(:prefixes) ? :prefixes : :suffixes
      fields = args[placement]
      unless fields
        raise "AttrSplitter: no prefixes or suffixes specified"
      end
      split_attrs = fields.collect do |f|
        if placement == :prefixes
          [f.to_s, attribute.to_s].join("_").to_sym
        else
          [attribute.to_s, f.to_s].join("_").to_sym
        end
      end
      
      dirty_attribute = attribute.to_s + "_dirty"
      define_method(dirty_attribute.to_sym) do
        instance_variable_get("@#{dirty_attribute}")
      end
      define_method("#{dirty_attribute}=") do |val|
        instance_variable_set("@#{dirty_attribute}", val)
      end

      split_attrs.each do |sa|
        define_method(sa) do
          instance_variable_get("@#{sa.to_s}")
        end
        define_method("#{sa.to_s}=") do |val|
          if(val.blank?)
            raise "SETTING BLANK VALUE"
          end
          instance_variable_set("@#{sa.to_s}", val)
          send("#{dirty_attribute}=", true)
        end
      end

      before_save do
        if send(dirty_attribute.to_sym) == true
          combined_value = split_attrs.collect{ |sa| send(sa.to_s) }.join
          send("#{attribute}=", combined_value)
        end
      end
    end
  end
end