require_relative '../../db/config'
require_relative '../database'

class MesaService
  def self.listar
    Banco.listar_mesas
  end

  def self.disponiveis(quantidade)
    Banco.mesas_disponiveis(quantidade)
  end
end