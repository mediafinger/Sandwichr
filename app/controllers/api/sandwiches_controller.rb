class Api::SandwichesController < ApplicationController
  before_action :ensure_sandwich, only: [:show, :update]

  def index
    sandwiches = Sandwich.all.limit(1000)
    render json: sandwiches
  end

  def show
    render json: @sandwich, status: :ok
  end

  def create
    sandwich = Sandwich.new(sandwich_params)

    if sandwich.save
      render json: sandwich, status: :created
    else
      render json: { errors: sandwich.errors.full_messages }, status: 422
    end
  end

  def update
    if @sandwich.update(sandwich_params)
      render json: @sandwich, status: :ok
    else
      render json: { errors: @sandwich.errors.full_messages }, status: 422
    end
  end

  private

  def sandwich_params
    params.require(:sandwich).permit(:name, :bread_type)
  end

  def ensure_sandwich
    @sandwich = Sandwich.find_by(id: params[:id])
    render(json: { errors: "Sandwich with id #{params[:id]} not found" }, status: 404) unless @sandwich
  end
end
