# db/config.rb
require 'sqlite3'

DB = SQLite3::Database.new("reservas.db")
DB.results_as_hash = true

DB.execute <<-SQL
  CREATE TABLE IF NOT EXISTS reservas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT,
    pessoas INTEGER,
    mesas TEXT
  );
SQL

DB.execute <<-SQL
  CREATE TABLE IF NOT EXISTS mesas (
    id INTEGER PRIMARY KEY,
    capacidade INTEGER
  );
SQL

# Preenchendo as mesas caso não existam
mesas_existem = DB.execute("SELECT COUNT(*) as total FROM mesas").first["total"]
if mesas_existem == 0
  DB.execute("INSERT INTO mesas (id, capacidade) VALUES (1, 2), (2, 4), (3, 4), (4, 6)")
end

# app/database.rb
require_relative '../db/config'

class BancoFake
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
