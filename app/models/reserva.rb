class Reserva
    attr_accessor :id, :nome, :horario, :pessoas, :mesas
  
    def initialize(attrs = {})
      @id = attrs[:id]
      @nome = attrs[:nome]
      @horario = attrs[:horario]
      @pessoas = attrs[:pessoas]
      @mesas = attrs[:mesas]
    end
    def to_hash
      {
        id:@id,
        nome:@nome,
        pessoas:@pessoas,
        mesas:@mesas
      }
    end
  end