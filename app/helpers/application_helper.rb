module ApplicationHelper
  def error_message_on(object, method)
    if object.errors[method].any?
      render "application/forms/error", message: object.errors[method].to_sentence
    end
  end
end
