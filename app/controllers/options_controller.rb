class OptionsController < ApplicationController
  before_action :set_option, only: [:show, :edit, :update]

  # GET /scenes
  def index
    @options = Option.all
  end

  # GET /options/1
  def show
  end

  # GET /options/1/edit
  def edit
  end

  # PATCH/PUT /options/1
  def update
    respond_to do |format|
      if @option.update(option_params)
        format.html { redirect_to options_url, notice: 'Option was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_option
    @option = Option.find(params[:id])
  end

  def option_params
    params.require(:option).permit(:value)
  end
end
