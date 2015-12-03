class ExtratosController < ApplicationController


  def index
    @filtro = ExtratoFiltro.new(params[:extrato_filtro] || {})
    
    @extratos = Extrato.includes(:tipo_operacao).where(
      conta_id: current_user.conta_id
    )

    puts @filtro.data_inicio

    if @filtro.valid? && params[:extrato_filtro]
      @extratos = @extratos.where(["created_at between ? and ?", @filtro.data_inicio.as_date, @filtro.data_fim.as_date])
    end
  end

  # GET /extratos/new
  def new
    @extrato = Extrato.new(tipo_operacao_id: params[:tipo_operacao_id])
  end

  def create
    @extrato = Extrato.new(extrato_params.merge(conta_id: current_user.conta_id))
    
    respond_to do |format|
      if @extrato.save
        format.html { redirect_to new_extrato_path(tipo_operacao_id: @extrato.tipo_operacao_id) , notice: "#{@extrato.tipo_operacao_nome} efetuado(a)" }
      else
        format.html { render :new }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extrato
      @extrato = Extrato.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def extrato_params
      params[:extrato].permit(:valor, :tipo_operacao_id, :nova_conta_id)
    end
end
