class ProductsController < ApplicationController

  before_action :is_admin?, only: [:edit, :update, :destroy]
  before_action :set_product, only: [:show]

  def is_admin?
    if current_user && current_user.role == 'admin'
      set_product
    else
      render plain: 'not authorized error'
    end
  end

  def is_vip?
    current_user && current_user.role == 'vip'
  end

  def is_normal?
    current_user && current_user.role.nil?
  end

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  def purchase
    @products = Product.all
    @user = User.find(current_user.id)
    respond_to do |format|
      if @user.update(role: 'vip')
        format.html {redirect_to root_path, notice: 'User was successfully updated as vip.'}
      else
        format.html {redirect_to root_path, notice: 'error!!!'}
      end
    end
  end

  def set_as_admin
    @products = Product.all
    @user = User.find(current_user.id)
    respond_to do |format|
      if @user.update(role: 'admin')
        format.html {redirect_to root_path, notice: 'User was successfully updated as admin.'}
      else
        format.html {redirect_to root_path, notice: 'error!!!'}
      end
    end
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id

    respond_to do |format|
      if @product.save
        format.html {redirect_to @product, notice: 'Product was successfully created.'}
        format.json {render :show, status: :created, location: @product}
      else
        format.html {render :new}
        format.json {render json: @product.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html {redirect_to @product, notice: 'Product was successfully updated.'}
        format.json {render :show, status: :ok, location: @product}
      else
        format.html {render :edit}
        format.json {render json: @product.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html {redirect_to products_url, notice: 'Product was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:name, :price, :image)
  end
end
