class EmailWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_id , condition)
    @user = User.find(user_id)

    case condition
      when "send_forgot_password"
        AppMailer.send_forgot_password(@user).deliver
    end
    
  end
end