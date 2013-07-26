module AttrSplitter
  module FormBuilderAdditions
    def multi_text_field(record_name, record_object = nil, fields_options = {}, &block)
      fields_options, record_object = record_object, nil if record_object.is_a?(Hash) && record_object.extractable_options?
      fields = fields_options.delete(:fields)
      label = fields_options.delete(:label) || record_name.to_s.titleize

      field_parts = "".html_safe
      value = @object.send(record_name)
      index = 0
      fields.each do |name, length|
        if value
          value_part = value.slice(index, length)
          index += length
        end

        width = "width: " + ((length.to_f/2) + (length.to_f/8)).to_s + "em; margin-right: 5px;"
        name = "#{@object_name}[#{name}_#{record_name}]"
        id = "#{@object_name}_#{name}_#{record_name}"
        field_parts += @template.text_field_tag(name, value_part, id: id, type: "text", maxlength: length, style: width)
      end

      content = @template.content_tag(:div, class: "control-group") do
        @template.content_tag(:div, label, class: "control-label") +
        @template.content_tag(:div, field_parts, class: "controls")
      end
    end
  end
end