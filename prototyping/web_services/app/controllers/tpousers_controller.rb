class TpousersController < ApplicationController
  # GET /tpousers/1
  # GET /tpousers/1.json
  def show
    puts '------------'
    puts params[:id].inspect
    puts '------------'
    @tpouser = Tpouser.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tpouser }
      format.js  { render :json => @tpouser, :callback => params[:callback] }
    end
  end
  def user
    puts '------------'
    puts params[:user].inspect
    puts '------------'
    @tpouser = Tpouser.find_by_user(params[:user])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tpouser }
      format.js  { render :json => @tpouser, :callback => params[:callback] }
    end
  end
  def email
    puts '------------'
    puts params[:email].inspect
    puts '------------'
    @tpouser = Tpouser.where("info.e_mail" => params[:email]).all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tpouser }
      format.js  { render :json => @tpouser, :callback => params[:callback] }
    end
  end
  def phone
    puts '------------'
    puts params[:phone].inspect
    puts '------------'
    @tpouser = Tpouser.where("info.phone" => params[:phone]).all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tpouser }
      format.js  { render :json => @tpouser, :callback => params[:callback] }
    end
  end
  def fname
    puts '------------'
    puts params[:first_name].inspect
    puts '------------'
    @tpouser = Tpouser.where("info.first_name" => params[:first_name]).all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tpouser }
      format.js  { render :json => @tpouser, :callback => params[:callback] }
    end
  end
  def lname
    puts '------------'
    puts params[:last_name].inspect
    puts '------------'
    @tpouser = Tpouser.where("info.last_name" => params[:last_name]).all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tpouser }
      format.js  { render :json => @tpouser, :callback => params[:callback] }
    end
  end
end
