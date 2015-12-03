class Extrato < ActiveRecord::Base
  
  belongs_to :tipo_operacao
  belongs_to :conta, validate: true, autosave: true

  belongs_to :nova_conta, class_name: "Conta", validate: true, autosave: true

  accepts_nested_attributes_for :conta, :nova_conta

  delegate :nome, :prefixo, :metodo, to: :tipo_operacao, prefix: true

  attr_accessor :conta_transferencia_id
  # toda operação possui extrato, portanto as operações serão incluídas neste model

  # valida valores negativos
  validates_numericality_of :valor, greater_than_or_equal_to: 0
  # valida se a nova conta existe
  validates_presence_of :nova_conta, message: "precisa ser válida", :if => Proc.new{ |f| f.tipo_operacao.metodo == "transferencia" }

  # processa o tipo de operação
  before_validation :processa_operacao

  # ordena por ordem de criação
  default_scope { order('created_at desc') }
  
  def valor_index
    "#{tipo_operacao_prefixo}#{valor}"
  end

  def processa_operacao
    send(tipo_operacao_metodo)
  end

  # depósito
  def deposito
    puts self.conta.saldo
    puts valor
    self.conta.saldo += valor
    puts self.conta.saldo
  end

  # saque
  def saque
    self.conta.saldo -= valor
  end

  # transferência
  def transferencia
    # taxa de transferência
    if valor > 1000
      taxa = 10
    elsif ![0,6].include?(Time.now.wday) && (Time.now.hour >= 9 && Time.now.hour < 18)
      taxa = 5
    else
      taxa = 7
    end

    self.valor += taxa
    
    # remove da conta atual
    self.conta.saldo -= valor
    self.descricao = "Transferência para a conta #{nova_conta.try(:id)} taxa de #{taxa}"

    # nova conta recebe transferência
    self.nova_conta.extratos.new({
      tipo_operacao_id: TipoOperacao.where(metodo: "recebe_transferencia").take.id,
      conta_transferencia_id: self.id,
      valor: valor,
    }) if nova_conta
  end

  # receber transferência
  def recebe_transferencia
    self.conta.saldo += valor
    self.descricao = "Transferência da conta #{self.conta_transferencia_id}"
  end

end
