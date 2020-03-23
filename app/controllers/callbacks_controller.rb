class CallbacksController < ApplicationController
  def streamlabs
    @streamlab_log = StreamlabLog.new(message: params.to_s)
    parms ={
      client_id: 'mA7ZLjbZFU1gkZ9TX5MOm7p9epDizMVw3FDe9frs',
      client_secret: 'sTJyXjYZjYBcFUgkqsRFHqFsRe1txSBRlGloH5lQ',
      scopes: 'donations.create donations.read alerts.create legacy.token socket.token points.read points.write alerts.write credits.write profiles.write jar.write wheel.write mediashare.control',
      redirect_uri: 'https://twitch-listener-rails.herokuapp.com/callbacks/streamlabs',
      grant_type: 'access_token',
      code: params[:code]
    }

    if params[:code]
      apit_endpoint = 'https://streamlabs.com/api/v1.0/'
      resp = HTTParty.post("#{apit_endpoint}token?#{parms.to_query}")
      @streamlab_log.save

      StreamlabLog.create(message: resp.headers.to_s)
      StreamlabLog.create(message: resp.code.to_s)
      StreamlabLog.create(message: resp.body.to_s)

      return render json: StreamlabLog.last(3), status: :ok
    end

    if @streamlab_log.save
      render json: @streamlab_log, status: :ok
    else
      render json: @streamlab_log.errors, status: :unprocessable_entity
    end
  end
end