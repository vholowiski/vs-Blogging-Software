class RegistrationsController < Devise::RegistrationsController
  def new
  logger.debug "new before super"
    super
  logger.debug "new after super"
  end

  def create
      super
    logger.debug "afer super"
    logger.debug "id: "+@user.id.to_s
    if @user.id == 1
    	@user.is_admin=1
    	@user.save
    end
  end

  def update
  logger.debug "in update before super"
    super
  logger.debug "in update after super"
  end

end 