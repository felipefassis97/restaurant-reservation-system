# app/routes/api.rb
require 'json'
require_relative '../services/reserva_service'
require_relative '../services/mesa_service'
require_relative '../jobs/enviar_confirmacao_job'

class API
  def call(env)
    req = Rack::Request.new(env)
    method = req.request_method
    path = req.path_info

    # Libera CORS no pré-flight (OPTIONS)
    if method == 'OPTIONS'
      return [200, cors_headers, []]
    end

    case
    when method == 'GET' && path == '/reservas'
      [200, cors_headers, [ReservaService.listar.to_json]]

    when method == 'POST' && path == '/reservas'
      body = JSON.parse(req.body.read)
      reserva = ReservaService.criar(body)
      EnviarConfirmacaoJob.perform_async(reserva)
      [201, cors_headers, [reserva.to_json]]

    when method == 'GET' && path.match(%r{^/reservas/\d+$})
      id = path.split("/").last
      reserva = ReservaService.buscar(id)
      return [404, cors_headers, [{ erro: "Reserva não encontrada" }.to_json]] unless reserva
      [200, cors_headers, [reserva.to_json]]

    when method == 'DELETE' && path.match(%r{^/reservas/\d+$})
      id = path.split("/").last
      reserva = ReservaService.cancelar(id)
      return [404, cors_headers, [{ erro: "Reserva não encontrada" }.to_json]] unless reserva
      [200, cors_headers, [{ mensagem: "Reserva cancelada" }.to_json]]

    when method == 'GET' && path == '/mesas'
      [200, cors_headers, [MesaService.listar.to_json]]

    when method == 'GET' && path == '/mesas/disponiveis'
      pessoas = req.params["pessoas"].to_i
      mesas = MesaService.disponiveis(pessoas)
      [200, cors_headers, [mesas.to_json]]

    else
      [404, cors_headers, [{ erro: "Rota não encontrada" }.to_json]]
    end
  end

  def cors_headers
    {
      'content-type' => 'application/json',
      'access-control-allow-origin' => '*',
      'access-control-allow-methods' => 'GET, POST, DELETE, OPTIONS',
      'access-control-allow-headers' => 'Content-Type'
    }
  end
  def json
    { 'content-type' => 'application/json' }
  end
end