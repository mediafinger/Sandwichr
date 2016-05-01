class Api::SandwichesController < ApplicationController
  def index
    sandwiches = Sandwich.all.limit(1000)
    render json: sandwiches
  end

  def show
    sandwich = Sandwich.find_by(id: params[:id])

    if sandwich
      render json: sandwich, status: :ok
    else
      render json: { errors: "Sandwich with id #{params[:id]} not found" }, status: 404
    end
  end

  def create
    sandwich = Sandwich.new(create_params)

    if sandwich.save
      render json: sandwich, status: :created
    else
      render json: { errors: sandwich.errors.full_messages }, status: 422
    end
  end

  private

  def create_params
    params.require(:sandwich).permit(:name, :bread_type)
  end
end
