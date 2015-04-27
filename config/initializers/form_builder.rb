class ActionView::Helpers::FormBuilder
  alias :orig_label :label

  # add a 'required' CSS class to the field label if the field is required
  def label(method, content_or_options = nil, options = nil, &block)
    if content_or_options && content_or_options.class == Hash
      options = content_or_options
    else
      content = content_or_options
    end

    options = add_required_class(options) if presence_required?(method)
    orig_label(method, content, options || {}, &block)
  end


  #def check_box(attribute_name, *args)
  #  hidden_field attribute_name, value: 0, id: false
  #  @template.content_tag 'label', class: 'checkbox', for: "#{@object_name}_#{attribute_name}" do
  #    options = args.extract_options!
  #    options[:include_hidden] = false
  #    args << options
  #    super(attribute_name, *args) + @template.content_tag('i') +
  #        @object.class.human_attribute_name(attribute_name)
  #  end
  #end

  private

  def add_required_class(options)
    return { class: 'required' } unless options.class == Hash
    new_class = ((options[:class].to_s || '') + ' required').split(' ').uniq.join(' ')
    options.merge!(class: new_class)
  end

  def presence_required?(method)
    object.class.respond_to?(:validators_on) && object.class.validators_on(method).collect(&:class).include?(ActiveRecord::Validations::PresenceValidator)
  end


  #text_field(object_name, method, options = {})




end

