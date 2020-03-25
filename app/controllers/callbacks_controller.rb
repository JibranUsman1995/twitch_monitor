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
    respond_to do |format|
      format.html
    end
  end
end