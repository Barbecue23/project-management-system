module ApplicationHelper
  def button(text, type: :primary, disabled: false, icon: nil)
    style_classes = case type
    when :primary then "btn btn-primary"
    when :secondary then "btn btn-secondary"
    when :disabled then "btn btn-disabled"
    else "btn"
    end

    render partial: "shared/button", locals: { text: text, style_classes: style_classes, disabled: disabled, icon: icon }
  end
end
