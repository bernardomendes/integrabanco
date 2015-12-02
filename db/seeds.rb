# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[
  { nome: "Depósito", metodo: "deposito", prefixo: "+"},
  { nome: "Transferência", metodo: "transferencia", prefixo: "-"},
  { nome: "Transferência Recebida", metodo: "recebe_transferencia", prefixo: "+"},
  { nome: "Saque", metodo: "saque", prefixo: "-"}
].each do |tipo_operacao|
  TipoOperacao.create(tipo_operacao)
end