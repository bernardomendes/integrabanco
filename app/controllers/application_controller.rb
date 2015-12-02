class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :set_actions

  def index
    
  end

  def set_actions
    @operacoes = TipoOperacao.where("metodo != 'recebe_transferencia'")
  end
end
