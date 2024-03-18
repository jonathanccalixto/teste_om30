# frozen_string_literal: true

class MunicipesController < ApplicationController
  before_action :build_municipe, only: %i[new create]

  # GET /municipes or /municipes.json
  def index; end

  # GET /municipes/1 or /municipes/1.json
  def show; end

  # GET /municipes/new
  def new; end

  # GET /municipes/1/edit
  def edit; end

  # POST /municipes or /municipes.json
  def create
    municipe.attributes = municipe_params

    respond_to do |format|
      if municipe.save
        format.html { redirect_to municipe_url(municipe), notice: 'Municipe was successfully created.' }
        format.json { render :show, status: :created, location: municipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: municipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /municipes/1 or /municipes/1.json
  def update
    respond_to do |format|
      if municipe.update(municipe_params)
        format.html { redirect_to municipe_url(municipe), notice: 'Municipe was successfully updated.' }
        format.json { render :show, status: :ok, location: municipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: municipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH /municipes/1/toggle or /municipes/1/toggle.json
  def toggle
    municipe = Municipe.find(params[:id])

    respond_to do |format|
      if municipe.toggle_status
        format.html { redirect_to municipes_url(municipe), notice: 'Municipe was successfully updated.' }
        format.json { render :show, status: :ok, location: municipe }
      end
    end
  end

  # DELETE /municipes/1 or /municipes/1.json
  def destroy
    municipe.destroy!

    respond_to do |format|
      format.html { redirect_to municipes_url, notice: 'Municipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def build_municipe
    @municipe = Municipe.new
  end

  def municipe
    @municipe ||= Municipe.find(params[:id])
  end
  helper_method :municipe

  def municipes
    @municipes ||= Municipe.all
  end
  helper_method :municipes

  # Only allow a list of trusted parameters through.
  def municipe_params
    params.require(:municipe).permit(
      :name, :cpf, :cns, :email, :birthday, :phone, :photo
    )
  end
end
