class ConvertRulesController < ApplicationController
  before_filter :authenticate_user!, :set_page_name

  # GET /convert_rules
  # GET /convert_rules.json
  def index
    @convert_rules = ConvertRule.where(:user_id => current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @convert_rules }
    end
  end

  # GET /convert_rules/1
  # GET /convert_rules/1.json
  def show
    @convert_rule = ConvertRule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @convert_rule }
    end
  end

  # GET /convert_rules/new
  # GET /convert_rules/new.json
  def new
    @convert_rule = ConvertRule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @convert_rule }
    end
  end

  # GET /convert_rules/1/edit
  def edit
    @convert_rule = ConvertRule.find(params[:id])
  end

  # POST /convert_rules
  # POST /convert_rules.json
  def create
    @convert_rule = ConvertRule.new(params[:convert_rule])

    @convert_rule.user_id = current_user.id
    @convert_rule.status = "valid"

    respond_to do |format|
      if @convert_rule.save
        format.html { redirect_to @convert_rule, notice: 'Convert rule was successfully created.' }
        format.json { render json: @convert_rule, status: :created, location: @convert_rule }
      else
        format.html { render action: "new" }
        format.json { render json: @convert_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /convert_rules/1
  # PUT /convert_rules/1.json
  def update
    @convert_rule = ConvertRule.find(params[:id])

    respond_to do |format|
      if @convert_rule.update_attributes(params[:convert_rule])
        format.html { redirect_to @convert_rule, notice: 'Convert rule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @convert_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /convert_rules/1
  # DELETE /convert_rules/1.json
  def destroy
    @convert_rule = ConvertRule.find(params[:id])
    @convert_rule.destroy

    respond_to do |format|
      format.html { redirect_to convert_rules_url }
      format.json { head :no_content }
    end
  end

  private
    def set_page_name
      @page_name = "converts"
    end
end
