class SiteSettingsController < ApplicationController
before_filter :authenticate_user!
  # GET /site_settings
  # GET /site_settings.json
  def index
    @site_settings = SiteSetting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @site_settings }
    end
  end

  # GET /site_settings/1
  # GET /site_settings/1.json
  def show
  	if current_user.is_admin==1
		@site_setting = SiteSetting.find(params[:id])
	
		respond_to do |format|
		  format.html # show.html.erb
		  format.json { render json: @site_setting }
		end
    end
  end

  # GET /site_settings/new
  # GET /site_settings/new.json
  def new
  	if current_user.is_admin==1
    @site_setting = SiteSetting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site_setting }
    end
    end
  end

  # GET /site_settings/1/edit
  def edit
    @site_setting = SiteSetting.find(params[:id])
    @categories=Category.all
  end

  # POST /site_settings
  # POST /site_settings.json
  def create
    if current_user.is_admin==1
    @site_setting = SiteSetting.new(params[:site_setting])

    respond_to do |format|
      if @site_setting.save
        format.html { redirect_to @site_setting, notice: 'Site settings were successfully created.' }
        format.json { render json: @site_setting, status: :created, location: @site_setting }
      else
        format.html { render action: "new" }
        format.json { render json: @site_setting.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # PUT /site_settings/1
  # PUT /site_settings/1.json
  def update
  	if current_user.is_admin==1
    @site_setting = SiteSetting.find(params[:id])

    respond_to do |format|
      if @site_setting.update_attributes(params[:site_setting])
        format.html { redirect_to :action=> :edit, notice: 'Site settings were successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site_setting.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # DELETE /site_settings/1
  # DELETE /site_settings/1.json
  def destroy
  	if current_user.is_admin==1
    @site_setting = SiteSetting.find(params[:id])
    @site_setting.destroy

    respond_to do |format|
      format.html { redirect_to site_settings_url }
      format.json { head :no_content }
    end
  end
  end
end
