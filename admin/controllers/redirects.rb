OsbonscompanheirosCom::Admin.controllers :redirects do
  get :index do
    @title = "Redirects"
    @redirects = Redirect.all
    render 'redirects/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'redirect')
    @redirect = Redirect.new
    render 'redirects/new'
  end

  post :create do
    @redirect = Redirect.new(params[:redirect])
    if @redirect.save
      @title = pat(:create_title, :model => "redirect #{@redirect.id}")
      flash[:success] = pat(:create_success, :model => 'Redirect')
      params[:save_and_continue] ? redirect(url(:redirects, :index)) : redirect(url(:redirects, :edit, :id => @redirect.id))
    else
      @title = pat(:create_title, :model => 'redirect')
      flash.now[:error] = pat(:create_error, :model => 'redirect')
      render 'redirects/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "redirect #{params[:id]}")
    @redirect = Redirect.find(params[:id])
    if @redirect
      render 'redirects/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'redirect', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "redirect #{params[:id]}")
    @redirect = Redirect.find(params[:id])
    if @redirect
      if @redirect.update_attributes(params[:redirect])
        flash[:success] = pat(:update_success, :model => 'Redirect', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:redirects, :index)) :
          redirect(url(:redirects, :edit, :id => @redirect.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'redirect')
        render 'redirects/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'redirect', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Redirects"
    redirect = Redirect.find(params[:id])
    if redirect
      if redirect.destroy
        flash[:success] = pat(:delete_success, :model => 'Redirect', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'redirect')
      end
      redirect url(:redirects, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'redirect', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Redirects"
    unless params[:redirect_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'redirect')
      redirect(url(:redirects, :index))
    end
    ids = params[:redirect_ids].split(',').map(&:strip)
    redirects = Redirect.find(ids)
    
    if Redirect.destroy redirects
    
      flash[:success] = pat(:destroy_many_success, :model => 'Redirects', :ids => "#{ids.to_sentence}")
    end
    redirect url(:redirects, :index)
  end
end
