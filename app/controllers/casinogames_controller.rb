class CasinogamesController < ApplicationController
  before_action :set_casinogame, only: %i[ show edit update destroy ]

  # GET /casinogames or /casinogames.json
  def index
    @casinogames = Casinogame.all
  end

  # GET /casinogames/1 or /casinogames/1.json
  def show
  end

  # GET /casinogames/new
  def new
    @casinogame = Casinogame.new
  end

  # GET /casinogames/1/edit
  def edit
  end

  # POST /casinogames or /casinogames.json
  def create
    @casinogame = Casinogame.new(casinogame_params.merge(user: current_user))


    respond_to do |format|
      if @casinogame.save
        format.html { redirect_to @casinogame, notice: "Casinogame was successfully created." }
        format.json { render :show, status: :created, location: @casinogame }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @casinogame.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /casinogames/1 or /casinogames/1.json
  def update
    respond_to do |format|
      if @casinogame.update(casinogame_params)
        format.html { redirect_to @casinogame, notice: "Casinogame was successfully updated." }
        format.json { render :show, status: :ok, location: @casinogame }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @casinogame.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /casinogames/1 or /casinogames/1.json
  def destroy
    @casinogame.destroy!

    respond_to do |format|
      format.html { redirect_to casinogames_path, status: :see_other, notice: "Casinogame was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_casinogame
      @casinogame = Casinogame.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def casinogame_params
      params.require(:casinogame).permit(:title, :description, :image, :user_id)
    end
end
