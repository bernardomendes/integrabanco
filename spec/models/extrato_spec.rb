require 'rails_helper'
require 'pp'

RSpec.describe Extrato, type: :model do
  it "taxa de transferencia de acordo com horário" do
    u1 = User.create(email: "444@a.com", password: "11111111")
    u2 = User.create(email: "123@a.com", password: "11111111")

    conta1 = u1.conta
    conta2 = u2.conta

    conta1.saldo = 10000
    conta1.save
    conta2.save

    # sabado
    now = Time.parse("2015-12-05")
    allow(Time).to receive(:now) { now }

    transferencia = Extrato.new({
      conta_id: conta1.id,
      tipo_operacao_id: TipoOperacao.where(metodo: "transferencia").take.id,
      nova_conta_id: conta2.id,
      valor: 1
    })

    transferencia.save

    # 1 da transferencia + 7 da taxa
    expect(conta1.reload.saldo).to eq(10000-7-1)

    # sexta as 10h
    now = Time.parse("2015-12-04 10:00")
    allow(Time).to receive(:now) { now }

    transferencia = Extrato.new({
      conta_id: conta1.id,
      tipo_operacao_id: TipoOperacao.where(metodo: "transferencia").take.id,
      nova_conta_id: conta2.id,
      valor: 1
    })

    transferencia.save

    # 1 da transferencia + 5 da taxa
    expect(conta1.reload.saldo).to eq(10000-7-1-5-1)

    # maior ou igual a 1000
    now = Time.parse("2015-12-04 10:00")
    allow(Time).to receive(:now) { now }

    transferencia = Extrato.new({
      conta_id: conta1.id,
      tipo_operacao_id: TipoOperacao.where(metodo: "transferencia").take.id,
      nova_conta_id: conta2.id,
      valor: 1001
    })

    transferencia.save

    # 1000 da transferencia + 10 da taxa
    expect(conta1.reload.saldo).to eq(10000-7-1-5-1-10-1001)
    

  end
end
