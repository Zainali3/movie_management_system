module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
    when :success
      "alert-success"
    when :error
      "alert-danger"
    when :alert
      "alert-danger"
    when :notice
      "alert-success"
    when :warning
      "alert-warning"
    else
      flash_type.to_s
    end
  end

  def render_image(image,file_size)
   image.object.image.url(file_size)
 end

end
