class ScenesController < ApplicationController
  before_action :set_scene, only: [:show, :edit, :update, :destroy]

  # TODO reduce renderer lookups

  # GET /scenes
  # GET /scenes.json
  def index
    @scenes = Scene.all
  end

  # GET /scenes/1
  # GET /scenes/1.json
  def show
  end

  # GET /scenes/renderer
  # Select renderer for a new scene
  def renderer
    @renderers = Renderer.all
  end

  # GET /scenes/new
  def new
    if params[:renderer] && Renderer.valid(params[:renderer])
      @scene = Scene.new(renderer_id: params[:renderer])
    else
      redirect_to renderer_new_scene_url
    end
  end

  # GET /scenes/1/edit
  def edit
  end

  # POST /scenes
  # POST /scenes.json
  def create
    @scene = Scene.new(scene_params)
    @scene.user = current_user
    begin
      scene_path = process_scene_file(scene_file_param)
      @scene.scene_path = scene_path
    rescue ActionController::ParameterMissing
      @file_missing = true
    end
    @scene.submit

    respond_to do |format|
      if @scene.save
        format.html { redirect_to @scene, notice: 'Scene was successfully created.' }
        format.json { render :show, status: :created, location: @scene }
      else
        format.html { render :new }
        format.json { render json: @scene.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scenes/1
  # PATCH/PUT /scenes/1.json
  def update
    respond_to do |format|
      if @scene.update(scene_params)
        format.html { redirect_to @scene, notice: 'Scene was successfully updated.' }
        format.json { render :show, status: :ok, location: @scene }
      else
        format.html { render :edit }
        format.json { render json: @scene.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scenes/1
  # DELETE /scenes/1.json
  def destroy
    @scene.destroy
    respond_to do |format|
      format.html { redirect_to scenes_url, notice: 'Scene was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scene
      @scene = Scene.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scene_params
      params.require(:scene).permit(*allowed_params(renderer_id_param))
    end

    def renderer_id_param
      params.require(:scene).require(:renderer_id)
    end

    def allowed_params(renderer_id)
      param_names = [ :title, :user_id, :renderer_id ]
      renderer = Renderer.find(renderer_id)
      renderer.generator_options.each do |option|
        param_names << "option_#{option.id}"
      end
      param_names
    end

    def scene_file_param
      params.require(:scene).require(:scene_file)
    end

    # Save the given file io to a secrets specified location, timestamp it and return the file path
    # @return [String] the full path to the saved scene file
    def process_scene_file(file_io)
      target_filename = scene_target_filename file_io.original_filename
      puts 'Opening file'
      File.open(target_filename, 'wb') do |file|
        file.write(file_io.read)
      end
      target_filename
    end

    def scene_target_filename(filename)
      stripped_filename = I18n.transliterate(filename).gsub(/[^0-9A-Za-z_.]/, '').downcase
      "#{Rails.application.secrets.fitrender_scenes_location}/#{Time.now.to_i}_#{stripped_filename}"
    end
end
