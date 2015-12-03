require 'rails_helper'

RSpec.describe User, type: :model do
  it "saldo nunca pode ficar negativo" do
    user = User.create(email: "testee@test.com", password: "11111111")
    conta = user.conta
    conta.saldo = -1
    conta.save

    expect(conta.errors[:saldo]).to eq(["deve ser maior ou igual a 0"])
  end
end
