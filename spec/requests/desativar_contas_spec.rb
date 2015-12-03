require 'rails_helper'
require 'pp'

RSpec.describe "DesativarContas", type: :request do
  it "conta não pode ser apagada" do
    user = User.create(email: "teste@t1.com", password: "11111111")
    id = user.id
    login_as(user, :scope => :user)
    visit edit_user_registration_path
    find('input[id="cancelar_conta"]').click
    user = User.find id
    login_as(user, :scope => :user)

    expect(page).to have_content("Para continuar, efetue login ou registre-se.")
    expect(user.deleted_at).not_to be_nil
    
  end
end
