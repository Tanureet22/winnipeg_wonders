class StaticPagesController < ApplicationController
  def contact
    if request.post?
      @name = params[:name]
      @message = params[:message]
      @user_email = params[:email]

      ContactMailer.contact_email(@name, @user_email, @message).deliver_now

      flash[:notice] = "Thank you for your message, #{@name}!"
      redirect_to contact_path
      @page = StaticPage.find_by(title: 'Contact')
    end
  end

  def show
    @static_page = StaticPage.find_by(title: params[:title].capitalize)
  end
  
  def about
    @page = StaticPage.find_by(title: 'About')
  end
end
