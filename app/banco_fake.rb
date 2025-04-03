class BancoFake
    @@reservas = []
    @@mesas = [
      { id: 1, capacidade: 2 },
      { id: 2, capacidade: 4 },
      { id: 3, capacidade: 4 },
      { id: 4, capacidade: 6 }
    ]
    @@contador = 1
  
    def self.salvar_reserva(dados)
      dados["id"] = @@contador
      @@contador += 1
      @@reservas << dados
      dados
    end
  
    def self.todas_reservas
      @@reservas
    end
  
    def self.encontrar_reserva(id)
      @@reservas.find { |r| r["id"] == id.to_i }
    end
  
    def self.deletar_reserva(id)
      reserva = encontrar_reserva(id)
      @@reservas.delete(reserva)
      reserva
    end
  
    def self.listar_mesas
      @@mesas
    end
  
    def self.mesas_disponiveis(quantidade)
      @@mesas.select { |m| m[:capacidade] >= quantidade }
    end

    def self.BancoFake
      
    end
  end