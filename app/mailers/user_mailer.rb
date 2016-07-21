class UserMailer < ApplicationMailer

default from: 'notifications@rottenmangoes.com'

  def user_deleted_email(user)
    @user = user
    mail(to: @user.email, subject:'You have been deleted')

  end

end
