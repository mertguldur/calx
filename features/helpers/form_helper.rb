module FormHelper
  def form_value(field, value)
    data = /^(.+)_characters$/.match(value)
    return value unless data

    size = data[1].to_i
    return email_value(size) if field == 'email'

    'a' * size
  end

  def event_type_radio_id(event_type)
    "##{event_type.downcase.split(' ').join('-')}-radio"
  end

  def datepicker_value(date)
    Date.parse(date).strftime('%m/%d/%Y')
  end

  private

  def email_value(size)
    size -= 6
    "a@#{'a' * size}.com"
  end
end

World(FormHelper)
