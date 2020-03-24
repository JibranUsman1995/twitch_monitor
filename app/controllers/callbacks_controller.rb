class CallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token
  protect_from_forgery except: %i[streamlabs create_log]

  def create_log
    resp = params[:message]

    if resp.present?
      if resp['for'].blank? && resp['type'] == 'donation'
        Donation.create(
          name: resp['message']['name'],
          currency: resp['message']['currency'],
          amount: resp['message']['amount'].to_i,
          from_name: resp['message']['from'],
          from_id: resp['message']['from_user_id'],
        )
        points = PointPerDonation.last.value
      end

      if resp['for'] == 'twitch_account'
        if resp['type'] == 'bits'
          Bit.create(
            name: resp['message']['name'],
            amount: resp['message']['amount'].to_i,
            message: resp['message']['message'],
          )
          points = PointPerBit.last.value
        elsif resp['type'] == 'subscription'
          Subscription.create(
            name: resp['message']['name'],
            message: resp['message']['message'],
            sub_plan: resp['message']['sub_plan'].to_i,
            sub_type: resp['message']['sub_type'],
          )
          points = PointPerSubscription.where(sub_type: resp['message']['']).last.value
        end
      end

      CurrentPoint.last.update(value: CurrentPoint.last.value + points)
      HighScore.last.update(value: CurrentPoint.last.value + HighScore.last.value)

      if CurrentPoint.last.value > Incentive.last.value
        CurrentPoint.last.update(value: CurrentPoint.last.value%Incentive.last.value)
        CurrentPoint.create(value: 0)
      end
    end

    StreamlabLog.create(message: params[:message])
    head :ok
  end

  def streamlabs
    @streamlab_log = StreamlabLog.new(message: params.to_s)
    parms ={
      'grant_type' => 'authorization_code',
      'client_id' => 'mA7ZLjbZFU1gkZ9TX5MOm7p9epDizMVw3FDe9frs',
      'client_secret' => 'sTJyXjYZjYBcFUgkqsRFHqFsRe1txSBRlGloH5lQ',
      'redirect_uri' => 'https://twitch-listener-rails.herokuapp.com/callbacks/streamlabs',
      'code' => 'IjR2UrETfUSMo5MPx1Kf3t4kcYwKnxt6qBvSkEm0',
    }

    respond_to do |format|
      format.html
    end

    if params[:code]
      # apit_endpoint = 'https://streamlabs.com/api/v1.0/'
      # query_str = parms.map{|k, v| k != 'redirect_uri' ? CGI::escape(k.to_s) + '=' + CGI::escape(v) : "#{k}=#{v}" }.join('&')
      # urll = "#{apit_endpoint}token"
      # resp = HTTParty.post(urll, body: parms)
      # @streamlab_log.save

      # # access_token: 'WqdbZHXt83yvabJBub4x9eEv4PbT6hHBn2eOX296'
      # # refresh_token: 'fuNRmmhDdKbLrO714B7Yg8RhByiXbiu2wkXwa8RL'
      # # socket_token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbiI6Ijg4NjFGNTJENDhGMThGQzQ3MDY3IiwicmVhZF9vbmx5Ijp0cnVlLCJwcmV2ZW50X21hc3RlciI6dHJ1ZSwidHdpdGNoX2lkIjoiMTM3MDg3ODAwIn0.57BnuQp4Wh7FuKYvywMeU-xyyG2v9riN0ISduHqRLnw'

      # StreamlabLog.create(message: urll)
      # StreamlabLog.create(message: resp.headers.to_s)
      # StreamlabLog.create(message: resp.code.to_s)
      # StreamlabLog.create(message: resp.body.to_s)

      # respond_to do |format|
      #   format.html
      #   # format.json {  }
      # end

      # return render json: StreamlabLog.last(4), status: :ok
    end

    # if @streamlab_log.save
    #   render json: @streamlab_log, status: :ok
    # else
    #   render json: @streamlab_log.errors, status: :unprocessable_entity
    # end
  end
end