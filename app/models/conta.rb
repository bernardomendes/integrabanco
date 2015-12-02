class Conta < ActiveRecord::Base

  # possui várias informações de extrato
  has_many :extratos

  # valida saldo e valores negativos 
  validates_numericality_of :saldo, greater_than_or_equal_to: 0

end
