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

    puts '--------------------------------'
    puts @tpouser.inspect
    puts params["tpouser.info"].inspect
    puts params["tpouser.info"]["phone"].inspect
    puts params["tpouser.info"][:phone].inspect
    puts '--------------------------------'

    respond_to do |format|
      if params[:tpouser]
        Tpouser.create(
          :user => params[:tpouser][:user],
          :count => Count.new(
          :closings => params["tpouser.count"][:closings],
          :prospects => params["tpouser.count"][:prospects],
          :listings => params["tpouser.count"][:listings],
          :contacts => params["tpouser.count"][:contacts]
          ),
          :info => Info.new(
          :first_name =>  params["tpouser.info"][:first_name],
          :last_name =>  params["tpouser.info"][:last_name],
          :phone =>  params["tpouser.info"][:phone],
          :e_mail =>  params["tpouser.info"][:e_mail]
          ),
        );
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

    puts '--------------------------------'
    puts @tpouser.inspect
    puts '--------------------------------'

    respond_to do |format|
      if params[:tpouser]
        @tpouser.update_attributes(params[:tpouser]);
        @tpouser.count.build(
        :prospects => params["tpouser.count"][:prospects],
        :contacts => params["tpouser.count"][:contacts],
        :closings => params["tpouser.count"][:closings],
        :listings => params["tpouser.count"][:listings],
        );
        @tpouser.info.build(
        :first_name => params["tpouser.info"][:first_name],
        :last_name => params["tpouser.info"][:last_name],
        :phone => params["tpouser.info"][:phone],
        :e_mail => params["tpouser.info"][:e_mail],
        );
        @tpouser.save!
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
end
