require_relative '../db/config'

class Banco
  def self.salvar_reserva(dados)
    DB.execute("INSERT INTO reservas (nome, pessoas, mesas) VALUES (?, ?, ?)",
               [dados["nome"], dados["pessoas"], dados["mesas"].join(",")])
    id = DB.execute("SELECT last_insert_rowid() AS id").first["id"]
    buscar_reserva(id)
  end

  def self.todas_reservas
    DB.execute("SELECT * FROM reservas")
  end

  def self.buscar_reserva(id)
    DB.execute("SELECT * FROM reservas WHERE id = ?", [id]).first
  end

  def self.deletar_reserva(id)
    reserva = buscar_reserva(id)
    DB.execute("DELETE FROM reservas WHERE id = ?", [id])
    reserva
  end

  def self.listar_mesas
    DB.execute("SELECT * FROM mesas")
  end

  def self.mesas_disponiveis(quantidade)
    DB.execute("SELECT * FROM mesas WHERE capacidade >= ?", [quantidade])
  end
end