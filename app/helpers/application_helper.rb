module ApplicationHelper
    def button(text, type: :primary, disabled: false, icon: nil)
      style_classes = case type
      when :primary then "bg-blue-100 text-blue-600 border hover:bg-blue-200"
      when :secondary then "border border-[#AFAFAF] text-gray-[#888888]"
      when :disabled then "bg-gray-200 text-gray-400 border border-gray-300"
      else "border border-gray-400 text-gray-600"
      end

    render partial: "shared/button", locals: { text: text, style_classes: style_classes, disabled: disabled, icon: icon }
    end
end
