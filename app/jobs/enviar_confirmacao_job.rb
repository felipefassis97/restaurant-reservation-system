class EnviarConfirmacaoJob
    def self.perform_async(reserva)
      Thread.new do
        sleep(1) # Simula envio
        puts "E-mail de confirmação enviado para #{reserva["nome"]}"
      end
    end
  end