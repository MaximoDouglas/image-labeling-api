class ImageClassesController < ApplicationController
  before_action :set_image_class, only: [:show, :update, :destroy]

  # GET /image_classes
  def index
    param_domain_id = params[:domain_id]
    if param_domain_id
      @image_classes = ImageClass.where(domain_id: param_domain_id)
    else
      @image_classes = ImageClass.all
    end
    
    render json: @image_classes
  end

  # GET /image_classes/1
  def show
    render json: @image_class
  end

  # POST /image_classes
  def create
    @image_class = ImageClass.new(image_class_params)

    if @image_class.save
      render json: @image_class, status: :created, location: @image_class
    else
      render json: @image_class.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /image_classes/1
  def update
    if @image_class.update(image_class_params)
      render json: @image_class
    else
      render json: @image_class.errors, status: :unprocessable_entity
    end
  end

  # DELETE /image_classes/1
  def destroy
    @image_class.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_class
      @image_class = ImageClass.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def image_class_params
      params.require(:image_class).permit(:name, :domain_id)
    end
end
