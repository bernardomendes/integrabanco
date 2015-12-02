class Conta < ActiveRecord::Base

  # possui várias informações de extrato
  has_many :extratos

  # depósito
  def deposito(valor)
    valida_valor(valor)

    self.saldo += valor
    self.criar_extrato(__method__, valor)
    self.save
  end

  # saque
  def saque(valor)
    valida_valor(valor)

    self.saldo -= valor
    self.criar_extrato(__method__, valor)
    self.save
  end

  # transferência
  def transferencia(valor, nova_conta)
    valida_valor(valor)

    # remove da conta atual
    self.saldo -= valor
    self.criar_extrato(__method__, valor, "Transferencia para a conta #{nova_conta.id}")

    # transfere para a nova conta
    nova_conta.saldo += valor
    nova_conta.criar_extrato(__method__, valor, "Transferência da conta #{self.id}")

    self.save
  end



  private

    # valida valor das transações
    def validar_valor(valor)
      self.errors.add :base, "valor precisa ser maior que 0" if valor <= 0
      self.errors.add :base, "saldo insuficiente" if valor > self.saldo
    end

    # criar extrato pra cada operação
    def criar_extrato(tipo_operacao, valor, descricao)

      operacao = TipoOperacao.find_by_method(tipo_operacao.to_s)

      self.extrato.new({
        tipo_operacao_id: operacao.id,
        valor: valor,
        descricao: descricao
      })

    end




end
