require "base64"
class CamerasController < ApplicationController
  before_filter :authenticate_user!, :set_page_name

  def show_by_place
    user = current_user
    @place = CameraPlace.find(params[:camera_place_id])

    if not @place or @place.user_id != user.id
      return render_404
    end

    @cameras = @place.cameras

  end

  # GET /cameras
  # GET /cameras.json
  def index
    user = current_user
    @cameras = Camera.where(:user_id => user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cameras }
    end
  end

  # GET /cameras/1
  # GET /cameras/1.json
  def show
    @camera = Camera.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @camera }
    end
  end

  # GET /cameras/new
  # GET /cameras/new.json
  def new
    @camera = Camera.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @camera }
    end
  end

  # GET /cameras/1/edit
  def edit
    @camera = Camera.find(params[:id])
  end

  # POST /cameras
  # POST /cameras.json
  def create
    image_data =  Base64.decode64(params[:image_data])
    image_data = image_data.gsub('data:image/jpeg;base64,', '')
    file_name = Digest::MD5.hexdigest(image_data)
    file_path = "/tmp/#{file_name}.jpeg"
    f=open(file_path, "wb") 
    f.puts(image_data) 
    f.close

    f = open(file_path, "rb")
    uploader = ImageUploader.new
    uploader.store!(f)
    

    @camera = Camera.new
    @camera.image_url = uploader.filename

    user = current_user
    @camera.user_id = user.id
    @camera.camera_place_id = params[:camera_place_id]

    respond_to do |format|
      if @camera.save
        format.html { redirect_to @camera, notice: 'Camera was successfully created.' }
        format.json { render json: @camera, status: :created, location: @camera }
      else
        format.html { render action: "new" }
        format.json { render json: @camera.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cameras/1
  # PUT /cameras/1.json
  def update
    @camera = Camera.find(params[:id])

    respond_to do |format|
      if @camera.update_attributes(params[:camera])
        format.html { redirect_to @camera, notice: 'Camera was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @camera.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cameras/1
  # DELETE /cameras/1.json
  def destroy
    @camera = Camera.find(params[:id])
    @camera.destroy

    respond_to do |format|
      format.html { redirect_to cameras_url }
      format.json { head :no_content }
    end
  end

  private
    def set_page_name
      @page_name = "camera_places"
    end
end
