class Admin::ProductsController < AdminController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @product.photos.build
  end

  def edit
    #code
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = 'Create product successfully.'
      redirect_to @product
    else
      flash.now[:alert] = 'Fail to create product.'
      render :new
    end
  end

  def update
    #code
  end

  def destroy
    #code
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price,
      photos_attributes: :image)
  end
end
