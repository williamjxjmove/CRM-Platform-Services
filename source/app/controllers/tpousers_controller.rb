class TpousersController < ApplicationController
  # GET /tpousers
  # GET /tpousers.json
  def index
    @tpousers = Tpouser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tpousers }
    end
  end

  # GET /tpousers/1
  # GET /tpousers/1.json
  def show
    @tpouser = Tpouser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tpouser }
    end
  end

  # GET /tpousers/new
  # GET /tpousers/new.json
  def new
    @tpouser = Tpouser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tpouser }
    end
  end

  # GET /tpousers/1/edit
  def edit
    @tpouser = Tpouser.find(params[:id])
  end

  # POST /tpousers
  # POST /tpousers.json
  def create
    @tpouser = Tpouser.new(params[:tpouser])

    respond_to do |format|
      if @tpouser.save
        format.html { redirect_to @tpouser, notice: 'Tpouser was successfully created.' }
        format.json { render json: @tpouser, status: :created, location: @tpouser }
      else
        format.html { render action: "new" }
        format.json { render json: @tpouser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tpousers/1
  # PUT /tpousers/1.json
  def update
    @tpouser = Tpouser.find(params[:id])

    respond_to do |format|
      if @tpouser.update_attributes(params[:tpouser])
        format.html { redirect_to @tpouser, notice: 'Tpouser was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tpouser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tpousers/1
  # DELETE /tpousers/1.json
  def destroy
    @tpouser = Tpouser.find(params[:id])
    @tpouser.destroy

    respond_to do |format|
      format.html { redirect_to tpousers_url }
      format.json { head :no_content }
    end
  end

  def contacts_in_range

    # @tpouser = Tpouser.find(params)
    @tpouser = params

    puts '====== <contacts in range> ======'
    puts params.inspect
    puts params[:login].inspect
    puts params[:startDate].inspect
    puts params[:endDate].inspect
    puts '------------------------------'
    
    # @tpouser = Tpouser.find_by_user(params[:user])
    respond_to do |format|
      format.html { render json: @tpouser }
      format.json { render json: @tpouser }
      format.js { render :json => @tpouser, :callback => params[:callback] }
    end
  end

  # http://192.168.56.32:3000/v1/user/contacts/count/createdForMonth/williamjxj/12
  def contacts_6month
    
    #@tpouser = Tpouser.find(params)
    @tpouser = params

    puts '====== <contacts 6month> ======'
    puts params.inspect
    puts params[:login].inspect
    puts params[:month].inspect
    puts '------------------------------'
    
    # @tpouser = Tpouser.where("info.first_name" => params[:first_name]).all
    respond_to do |format|
      format.html { render json: @tpouser }
      format.json { render json: @tpouser }
      format.js { render :json => @tpouser, :callback => params[:callback] }
    end
  end

  #http://192.168.56.32:3000/v1/user/contacts/count/1234
  def total_number
    
    #@tpouser = Tpouser.find(params[:login])
    @tpouser = params

    puts '====== <total number> ======'
    puts params.inspect
    puts params[:login].inspect
    puts '------------------------------'

    # @tpouser = Tpouser.where("info.last_name" => params[:last_name]).all
    respond_to do |format|
      format.html { render json: @tpouser }
      format.json { render json: @tpouser }
      format.js { render :json => @tpouser, :callback => params[:callback] }
    end
  end

end
