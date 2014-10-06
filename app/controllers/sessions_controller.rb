class SessionsController < ApplicationController
  skip_before_action :authentication_required

  def new
    if params[:id] && params[:hash]
      if (user = User.find(params[:id]))
        stored_hash = user.password_digest.split('.').first
        if stored_hash == params[:hash]
          flash.alert = 'Innlogging OK.'
          session[:user_id] = user.id
          redirect_to root_path
        else
          flash.now.alert = "Innlogging feilet (feil passord: #{stored_hash.inspect} != #{params[:hash].inspect})."
        end
      else
        flash.now.alert = 'Innlogging feilet (ukjent bruker).'
      end
    end
    @email = cookies[:login_email]
  end

  def send_email
    user = User.find_by_email(params[:email])
    if user
      UserMailer.login(user).deliver!
      cookies.permanent[:login_email] = user.email
      redirect_to :log_in, notice: 'En e-post med innloggingslink er sendt til din e-postadresse.'
    else
      flash.now.alert = 'Ukjent e-postadresse'
      render 'new'
    end
  end

  def await_email
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => 'Logget inn!'
    else
      flash.now.alert = 'Feil e-post eller passord.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => 'Logget ut!'
  end
end
