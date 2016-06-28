module UsersHelper
  def user_pic_path(user)
    user.attachment ? user.attachment.image.url(:medium) : 'medium/missing.png'
  end
end
