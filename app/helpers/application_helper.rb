# encoding: utf-8
module ApplicationHelper

  def humannize_boolean(boolean)
    boolean ? I18n.t('yes_label') : I18n.t('no_label')
  end

  # def enum_translate(instance, enum, value)
  #   translate( :"activerecord.attributes.#{instance.class.name.underscore}.#{enum.to_s.pluralize}.#{value}",  default: value.to_s.humanize)
  # end

  def translate_enum(instance, enum, value)
    t(value, scope: [:activerecord, :attributes, instance, enum], default: value.to_s.humanize)
  end


  def enums_to_translated_options_array(object, klass, enum)
    enum_values = klass.send(enum)
    enum_values.map do |enum_value, db_value|
      translated = translate_enum(object.model_name.param_key.to_sym, enum.singularize, enum_value) #enum_to_translated_option(klass, enum, enum_value)
      [translated, enum_value]
    end.reject { |translated, enum_value| translated.blank? }
  end

  def enums_to_translated_options_collection(object, enum)
    #klass.__send__(enum.to_s.pluralize).collect { |s| [t("#{s[0]}"), s[0]] }
    object.class.__send__(enum.to_s.pluralize).collect do  |s|
      [t("#{s[0]}"), s[0]]
    end
  end


  def options_for_enum(klass, enum, object)
    options = enums_to_translated_options_array(object, klass, enum.to_s.pluralize)
    #options = enums_to_translated_options_collection(object, enum)
    options_for_select(options, object.send(enum))
  end


  def enum_select(f, enum, options = {}) # TODO - !!! .... terminar implementacao(verificar merge class :parmas[:class])
    f.select enum, options_for_enum(f.object.class, enum, f.object), options, class: 'form-control'
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
      form_instance.text_field(field, class: 'form-control data', value: (val)) +
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
  #    - label: label
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

  def collection_check_boxes_for(f, collection_ids, collection, id, label, html_options={})

    f.collection_check_boxes collection_ids, collection, id, label do |b|
      #b.label { b.check_box }
      # or
      #  b.label(class: "my-#{ b.object.class.name.parameterize }", 'data-value'=> b.value) { b.check_box + b.text }

       html = content_tag :div, class: 'form-group checkbox' do
         content_tag :label do
           b.check_box(html_options) +
               content_tag(:span, class: 'glyphicon glyphicon-ok', style: 'top: 0px !important; position: absolute; margin-left: -19px;  padding-right: 0px;') {} + b.label('data-value'=> b.value, style: 'padding-left: 10px;')
         end
       end
       html.html_safe


    end

  end


  # def check_box_tag_for(f, field, html_options={})
  #   label = html_options[:label].blank? ? field : html_options[:label]
  #
  #   html =
  #       content_tag :div, class: 'form-group checkbox' do
  #         content_tag :label do
  #           check_box_tag(f, field, field) +
  #               content_tag(:span, class: 'glyphicon glyphicon-ok') {} + label_tag(label)
  #         end
  #       end
  #
  #   html.html_safe
  # end

  def radio_button_for(f, field, tag_value, html_options={})
    label = html_options[:label].blank? ? field : html_options[:label]

    html = content_tag :div, class: 'radio' do
      content_tag :label do
        f.radio_button(field, tag_value, html_options) +
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
        'alert-danger' # Red   'alert-error'
      when 'notice' then
        'alert-info' # Blue
      when 'success' then
        'alert-success' # Green
      else
        flash_type.to_s
    end
  end

  #Renderizar 'no records' ou a pagina de listagem do modelo
  def render_index(itens, partial)
    if itens.empty?
      html = render partial: 'shared/no_records'
    else
      html = render partial: partial

      html += content_tag(:div, class: 'actions pull-left') do
        content_tag(:div, class: 'page_info') do
          page_entries_info(itens)
        end
      end
      html += will_paginate(itens)
    end

    html.html_safe
  end

end
