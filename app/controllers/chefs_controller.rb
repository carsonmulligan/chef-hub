class ChefsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      # @chefs = Chef.where(cuisine: params[:query])
      sql_query = "cuisine ILIKE :query OR location ILIKE :query OR nickname ILIKE :query"
      @chefs = Chef.where(sql_query, query: "%#{params[:query]}%")
    else
      @chefs = Chef.all
    end

    @markers = @chefs.geocoded.map do |chef|
      {
        lat: chef.latitude,
        lng: chef.longitude,
        info_window: render_to_string(partial: "info_window", locals: {chef: chef })

      }
    end
  end

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    @chef.user = current_user
    if @chef.save
    redirect_to '/'
    else
      render :new
    end
  end

  def show
    @chef = Chef.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def chef_params
    params.require(:chef).permit(:nickname, :location, :price, :description, :cuisine, :photo)
  end
end
