class ExtratoFiltro
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :data_inicio, :data_fim

  validate :check_datas

  def initialize(attributes = {})
    (attributes || {}).each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  private

  def check_datas
    errors.add(:data_inicio, "inválida") if data_inicio && !data_inicio.as_date
    errors.add(:data_fim, "inválida") if data_fim && !data_fim.as_date
  end

end