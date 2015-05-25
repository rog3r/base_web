# encoding: utf-8
module ApplicationHelper

  def humanize_boolean(boolean)
    #boolean ? 'Sim' : 'Não' # TODO - internacionalizar usando linha abaixo:
    boolean ? t('yes_label') : t('no_label')
  end

  def image_check_box_tag(checked)
    icon = 'unchecked.png'
    if checked
      icon = 'thin-0155_delete_remove_exit_close_checkbox-32.png'
    end
    image_tag(icon, class: 'image-check-box', width: 20, height: 20)
  end


  def image_radio_buttom_tag(checked)
    icon = 'radiobutton-unchecked.png'
    if checked
      icon = 'radiobutton-checked.png'
    end
    image_tag(icon, class: 'image-check-box', width: 20, height: 20)
  end

  def date_picker_for(form_instance, field, val, options = {})
    html = content_tag :div, class: 'input-group date datepicker' do
      form_instance.text_field(field, class: 'form-control', value: (val)) +
          content_tag(:span, class: 'input-group-addon') do
            content_tag(:i, class: 'glyphicon glyphicon-calendar') {}
          end
    end
    html.html_safe
  end

  # Runs a subprocess and applies handlers for stdout and stderr
  # Params:
  # - f: form instance
  # - field: attribute
  # - html_options: Params
  # - label: label
  # TODO - Corrigir funcionamento no IE, não marca nem desmarca o check!
  def check_box_for(f, field, html_options={})
    label = html_options[:label].blank? ? field : html_options[:label]

    html = content_tag :div, class: 'form-group checkbox' do
      content_tag :label do
        f.check_box(field) +
            content_tag(:span, class: 'glyphicon glyphicon-ok', style: 'top: 0px !important; position: absolute; margin-left: -19px;  padding-right: 0px;') {} + f.label(label, style: 'padding-left: 10px;')
      end
    end
    html.html_safe
  end
 
  def radio_button_for(f, field, tag_value, html_options={})
    label = html_options[:label].blank? ? field : html_options[:label]

    html = content_tag :div, class: 'radio' do
      content_tag :label do
        f.radio_button(field, tag_value) +
            content_tag(:span) {} + f.label(label)
      end
    end

    html.html_safe
  end


# Helper para o SearchForm do ransak
  def link_to_add_fields(name, f, type, klass = '')
    new_object = f.object.send "build_#{type}"
    id = "new_#{type}"
    fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
      render('search_shared/'+ type.to_s + '_fields', f: builder)
    end

    link_to(name, '#', class: "add_fields #{klass[:class] }", data: {id: id, fields: fields.gsub('\n', '')})
  end

# Flash Messages Display css control by RJO
  def flash_class(flash_type)
    case flash_type.to_s
      when 'alert' then
        'alert-warning' # Yellow 'alert-block'
      when 'error' then
        'alert-error' # Red   'alert-danger'
      when 'notice' then
        'alert-info' # Blue
      when 'success' then
        'alert-success' # Green
      else
        flash_type.to_s
    end
  end

end
