class ProductsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:confirmation]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def pay
    @product = Product.find(params[:id])
    @payment = Payment.create

    @payment.order_id = @payment.id.to_s + SecureRandom.random_number(10).to_s
    @payment.session_id = SecureRandom.random_number(10).to_s
    @payment.amount = @product.price
    @payment.save

    @tbk_tipo_transaccion = "TR_NORMAL"
    @tbk_url_cgi = "http://186.64.122.15/cgi-bin/juancri/tbk_bp_pago.cgi"
    @tbk_url_exito = "http://juancri.beerly.cl/products/success"
    @tbk_url_fracaso = "http://juancri.beerly.cl/products/failure"
  end

  def confirmation
    logger.info 'Hola me estoy llamando'
    render text: 'ACEPTADO'
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

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :price)
    end
end
