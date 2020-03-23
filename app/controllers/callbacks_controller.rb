class CallbacksController < ApplicationController
  def streamlabs
    @streamlab_log = StreamlabLog.new(message: params.to_s)
    parms ={
      grant_type: 'authorization_code',
      client_id: 'mA7ZLjbZFU1gkZ9TX5MOm7p9epDizMVw3FDe9frs',
      client_secret: 'sTJyXjYZjYBcFUgkqsRFHqFsRe1txSBRlGloH5lQ',
      redirect_uri: 'https://twitch-listener-rails.herokuapp.com/callbacks/streamlabs',
      code: params[:code],
    }

    if params[:code]
      apit_endpoint = 'https://streamlabs.com/api/v1.0/'
      query_str = parms.map{|k, v| CGI::escape(k.to_s) + '=' + CGI::escape(v)}.join('&')
      urll = "#{apit_endpoint}token?#{query_str}"
      resp = HTTParty.post(urll)
      @streamlab_log.save

      StreamlabLog.create(message: urll)
      StreamlabLog.create(message: resp.headers.to_s)
      StreamlabLog.create(message: resp.code.to_s)
      StreamlabLog.create(message: resp.body.to_s)

      return render json: StreamlabLog.last(4), status: :ok
    end

    if @streamlab_log.save
      render json: @streamlab_log, status: :ok
    else
      render json: @streamlab_log.errors, status: :unprocessable_entity
    end
  end
end