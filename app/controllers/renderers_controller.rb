class RenderersController < ApplicationController
  before_filter :authenticate_admin!

  before_action :set_renderer, only: [:show, :update]

  # GET /renderers
  # GET /renderers.json
  def index
    @renderers = Renderer.all
  end

  # GET /renderers/1
  # GET /renderers/1.json
  def show
  end

  # PATCH/PUT /scenes/1
  def update
    if @renderer.update(renderer_params)
      redirect_to @renderer, notice: 'Renderer was successfully updated.'
    else
      render :show
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_renderer
      @renderer = Renderer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def renderer_params
      params.require(:renderer).permit(*allowed_params)
    end

    def allowed_params
      param_names = []
      @renderer.options_list.each do |option|
        param_names << "option_#{option.id}"
      end
      param_names
    end
end
