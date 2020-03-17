class CallbacksController < ApplicationController
  def streamlabs
    @streamlab_log = StreamlabLog.new(message: params.to_s)

    if @streamlab_log.save
      render json: @streamlab_log, status: :ok
    else
      render json: @streamlab_log.errors, status: :unprocessable_entity
    end
  end
end