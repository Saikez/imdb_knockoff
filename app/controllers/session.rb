ImdbKnockoff::App.controllers :session do
  get :new do
    render :new
  end

  post :create, map: '/session' do
    # Note: This is ENTIRELY insecure!
    if params[:username] == 'ben' && params[:password] == 'p@55word'
      session[:authenticated] = true
      redirect url(:movies, :new)
    else
      halt 403, 'NOT AUTHORISED'
    end
  end
end
