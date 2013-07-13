class CameraPlacesController < ApplicationController
  before_filter :authenticate_user!, :set_page_name

  def add_place_moniter
    user = current_user
    @place = user.CameraPlaces.where(:id => params[:camera_place_id]).first
    if not @place
      return render_404
    end
    #@camera_place = CameraPlace.find(params[:camera_place_id])
  end

  # GET /camera_places
  # GET /camera_places.json
  def index
    user = current_user
    @camera_places = user.CameraPlaces

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @camera_places }
    end
  end

  # GET /camera_places/1
  # GET /camera_places/1.json
  def show
    @camera_place = CameraPlace.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @camera_place }
    end
  end

  # GET /camera_places/new
  # GET /camera_places/new.json
  def new
    @camera_place = CameraPlace.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @camera_place }
    end
  end

  # GET /camera_places/1/edit
  def edit
    @camera_place = CameraPlace.find(params[:id])
  end

  # POST /camera_places
  # POST /camera_places.json
  def create
    user = current_user
    @camera_place = CameraPlace.new(params[:camera_place])
    @camera_place.user_id = user.id

    respond_to do |format|
      if @camera_place.save
        format.html { redirect_to camera_places_path, notice: 'Camera place was successfully created.' }
        format.json { render json: @camera_place, status: :created, location: @camera_place }
      else
        format.html { render action: "new" }
        format.json { render json: @camera_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /camera_places/1
  # PUT /camera_places/1.json
  def update
    @camera_place = CameraPlace.find(params[:id])

    respond_to do |format|
      if @camera_place.update_attributes(params[:camera_place])
        format.html { redirect_to @camera_place, notice: 'Camera place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @camera_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /camera_places/1
  # DELETE /camera_places/1.json
  def destroy
    @camera_place = CameraPlace.find(params[:id])
    @camera_place.destroy

    respond_to do |format|
      format.html { redirect_to camera_places_url }
      format.json { head :no_content }
    end
  end

  private
    def set_page_name
      @page_name = "camera_places"
    end
end
