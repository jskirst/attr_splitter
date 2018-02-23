module AttrSplitter
  module FormBuilderAdditions
    def multi_text_field(record_name, record_object = nil, fields_options = {}, &block)
      fields_options, record_object = record_object, nil if record_object.is_a?(Hash) && record_object.extractable_options?
      placement = fields_options.include?(:prefixes) ? :prefixes : :suffixes
      fields = fields_options.delete(placement)
      include_jump = fields_options.delete(:include_jump) || false
      obscure_text = fields_options.delete(:obscure_text) || false
      label = fields_options.delete(:label) || record_name.to_s.titleize

      field_parts = "".html_safe
      value = @object.send(record_name)
      next_input = nil
      fields = fields.to_a.reverse.flatten
      fields = Hash[*fields]
      raise "AttrSplitter: No fields present" if fields.empty?
      fields.each_with_index do |(name, length), i|
        options = fields_options
        field_name = [name, record_name] if placement == :prefixes
        field_name = [record_name, name] if placement == :suffixes
        field_name = field_name.map{|a| a.to_s}.join("_")

        # Make sure field exists.
        begin
          @object.send(field_name)
        rescue
          raise "AttrSplitter: #{field_name} does not exist."
        end

        if value
          start = value.length - length
          value_part = value.slice(start, value.length)
          value = value.slice(0, start)
        end

        options[:maxlength] = length
        options[:name] = "#{@object_name}[#{field_name}]"
        options[:id] = "#{@object_name}_#{field_name}"
        options[:style] = "width: " + ((length.to_f/2) + (length.to_f/8)).to_s + "em; margin-right: 5px;"

        if include_jump and next_input
          options[:onkeyup] = "if(this.value.length == this.maxLength){ document.getElementById('#{next_input}').focus();}"
        end
        next_input = options[:id]

        if obscure_text
          options[:onblur] = "if(this.value.length == this.maxLength){ this.type = 'password'; }"
          options[:onfocus] = "this.type = 'text';"
          new_part = @template.password_field_tag(name, value_part, options)
        else
          new_part = @template.text_field_tag(name, value_part, options)
        end
        
        field_parts = new_part + field_parts
      end
      content = @template.content_tag(:div, class: "control-group") do
        @template.content_tag(:div, label, class: "control-label") +
        @template.content_tag(:div, field_parts, class: "controls")
      end
    end
  end
end
