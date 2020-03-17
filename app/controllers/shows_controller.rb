class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy]

  # GET /shows
  # GET /shows.json
  def index
    @shows = Show.left_joins(:channel).all
    if params[:search].present?
      @shows = @shows.where("lower(shows.name) LIKE (?) OR lower(channels.name) LIKE (?)","%#{params[:search].strip.downcase}%","%#{params[:search].strip.downcase}%")
    end
  end
 

  def mark_as_favourite
    if params[:show_id].present?
      @favourite = Favourite.new
      @favourite.user_id = current_user.id
      @favourite.show_id = params[:show_id]
      if @favourite.save
        SendFavouriteShowWorker.perform_in(@favourite.show.play_time - 30.minutes, current_user.email, @favourite.show_id)

        flash[:success] = "Successfully marked as favourite"
      else
        flash[:error] = "Something went wrong"
      end
    else
      flash[:error] = "Parameters not present"
    end
    redirect_to shows_path
  end


  # GET /shows/1
  # GET /shows/1.json
  def show
  end

  # GET /shows/new
  def new
    @show = Show.new
  end

  # GET /shows/1/edit
  def edit
  end

  # POST /shows
  # POST /shows.json
  def create
    @show = Show.new(show_params)

    respond_to do |format|
      if @show.save
        format.html { redirect_to @show, notice: 'Show was successfully created.' }
        format.json { render :show, status: :created, location: @show }
      else
        format.html { render :new }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shows/1
  # PATCH/PUT /shows/1.json
  def update
    respond_to do |format|
      if @show.update(show_params)
        format.html { redirect_to @show, notice: 'Show was successfully updated.' }
        format.json { render :show, status: :ok, location: @show }
      else
        format.html { render :edit }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shows/1
  # DELETE /shows/1.json
  def destroy
    @show.destroy
    respond_to do |format|
      format.html { redirect_to shows_url, notice: 'Show was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show
      @show = Show.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def show_params
      params.require(:show).permit(:name, :play_time, :channel_id)
    end
end
