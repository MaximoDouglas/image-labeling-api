class DomainsController < ApplicationController
  before_action :set_domain, only: [:show, :update, :destroy]

  # GET /domains
  def index
    @domains = Domain.all

    render json: @domains
  end

  # GET /domains/1
  def show
    render json: @domain
  end

  # POST /domains
  def create
    @domain = Domain.new(domain_params)

    if @domain.save
      render json: @domain, status: :created, location: @domain
    else
      render json: @domain.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /domains/1
  def update
    if @domain.update(domain_params)
      render json: @domain
    else
      render json: @domain.errors, status: :unprocessable_entity
    end
  end

  # DELETE /domains/1
  def destroy
    @domain.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_domain
      @domain = Domain.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def domain_params
      params.require(:domain).permit(:description)
    end
end
