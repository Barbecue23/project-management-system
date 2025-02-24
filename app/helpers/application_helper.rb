module ApplicationHelper
    def button(text, type: :primary, disabled: false)
      style_classes = case type
                      when :primary then "bg-blue-100 text-blue-800 border border-blue-300"
                      when :secondary then "border border-[#464E5F] text-gray-700"
                      when :disabled then "bg-gray-200 text-gray-400 border border-gray-300"
                      else "border border-gray-400 text-gray-600"
                      end
  
      render partial: "shared/button", locals: { text: text, style_classes: style_classes, disabled: disabled }
    end
  end
  