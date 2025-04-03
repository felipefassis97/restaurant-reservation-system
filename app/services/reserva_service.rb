require_relative '../../db/config'
require_relative '../database'

class ReservaService
  def self.criar(dados)
    mesas = Banco.mesas_disponiveis(dados["pessoas"])
    dados["mesas"] = mesas.map { |m| m["id"] }[0..0]  # agora as chaves são strings
    Banco.salvar_reserva(dados)
  end

  def self.listar
    Banco.todas_reservas
  end

  def self.buscar(id)
    Banco.buscar_reserva(id)
  end

  def self.cancelar(id)
    Banco.deletar_reserva(id)
  end
end
