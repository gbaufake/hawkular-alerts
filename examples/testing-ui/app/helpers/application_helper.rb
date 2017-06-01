module ApplicationHelper
  def bootstrap_class_for flash_type
    case flash_type
    when "success"
        "alert-success"
      when "error"
        "alert-danger"
      when "alert"
        "alert-block"
      when "notice"
        "alert-info"
    end
  end
end
