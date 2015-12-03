require 'rails_helper'
require 'pp'

RSpec.describe "TransacoesPrecisamLogins", type: :request do
  it "todas as transações precisam estar logado" do
    visit extratos_path
    expect(page).to have_content("Para continuar, efetue login ou registre-se.")
    visit new_extrato_path
    expect(page).to have_content("Para continuar, efetue login ou registre-se.")
  end
end
