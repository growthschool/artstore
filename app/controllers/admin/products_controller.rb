class Admin::ProductsController < AdminController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @photo = @product.build_photo
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])

    if @product.photo == nil
      @photo = @product.build_photo
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path, alert: "產品已刪除"
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, photo_attributes: [:image, :id])
  end
end
