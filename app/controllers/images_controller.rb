#coding: utf-8
class ImagesController < ApplicationController
  before_filter :authenticate_user!, :set_page_name, :except => [:display, :convert]

  # GET /images
  # GET /images.json
  def index
    user = current_user

    @all_images = Image.where(user_id: user.id)
    @images = @all_images.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/new
  # GET /images/new.json
  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.json
  def create
    uploader = nil
    original_filename = nil

    images = []
    user = current_user

    params[:files].each{|f|
      uploader = ImageUploader.new
      uploader.store!(f)
      original_filename = f.original_filename
        
      magick = MiniMagick::Image.open(uploader)

      image = Image.new({user_id: user.id, file_size: magick["%b"].to_i, title:original_filename, file_id:uploader.filename, width:magick[:width], height:magick[:height], format: magick["%m"]})

      image.folder_list = "默认"

      if image.save
        images << image
      else
        images << {title: original_filename, error: "保存失败", errors: image.errors}
      end
    }


    respond_to do |format|
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render json: {files: images}, status: :created}
    end
  end

  # PUT /images/1
  # PUT /images/1.json
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image = Image.find(params[:id])
    @image.status = -1
    @image.save

    respond_to do |format|
      format.html { redirect_to images_url }
      format.json { head :no_content }
    end
  end

  def display
    data=File.new("/tmp/images/"+params[:filename]+"."+params[:format], "rb").read
    send_data(data, :type=>"image/png", :disposition => "inline")  
  end

  def convert
    file_id = params[:filename]+"."+params[:format]
    image = Image.find_by_file_id(file_id)

    if not image
    end

    convert_rule = ConvertRule.where(:user_id => image['user_id'], :symbol => params[:convert_rule]).first


    if not convert_rule
    end

    file_path = "/tmp/images/"+file_id
    image = MiniMagick::Image.open(file_path)
    converts = JSON::parse(convert_rule.description)

    converts.each { |convert|
      if convert[0] == "resize"
        image.combine_options do |c|
          c.resize "#{convert[1]['width']}x#{convert[1]['height']}"
          c.background "white"
          c.gravity "center"
          c.extent "#{convert[1]['width']}x#{convert[1]['height']}"
        end
      end
    }
    send_data(image.to_blob, :type=>"image/png", :disposition => "inline")  
  end

  private
    def set_page_name
      @page_name = "images"
    end
end
