class Admin::ProductsController < ProductsController
  before_action :authenticate_user!
  before_action :admin_required
  layout 'admin'

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

  def edit ; end

  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  # def index
  #  @products = Product.all
  # end

  # def show ; end

  def destroy
    if @product.destroy
      flash[:success] = 'Product has been destroyed.'
    else
      flash[:danger] = 'Failed.'
    end
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, photo_attributes: [ :id, :image ])
  end
end
