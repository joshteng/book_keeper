class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  # GET /books
  # GET /books.json
  def index
    @books = current_user.books
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @debit_transactions = @book.transactions.debit
    @credit_transactions = @book.transactions.credit

    if params[:filter] && params[:filter][:period].present?
      start_date = params[:filter][:period][:start_date]
      start_date = Date.strptime("{ #{start_date[:year]}, #{start_date[:month]}, #{start_date[:day]} }", "{ %Y, %m, %d }")

      end_date = params[:filter][:period][:end_date]
      end_date = Date.strptime("{ #{end_date[:year]}, #{end_date[:month]}, #{end_date[:day]} }", "{ %Y, %m, %d }")

      # raise

      @debit_transactions = @book.transactions.debit.period(start_date, end_date)
      @credit_transactions = @book.transactions.credit.period(start_date, end_date)
    else
      today = Date.today
      beginning_of_month = today.beginning_of_month

      @debit_transactions = @book.transactions.debit.period(beginning_of_month, today)
      @credit_transactions = @book.transactions.credit.period(beginning_of_month, today)
    end

    @total_debit_transactions = @debit_transactions.sum(:amount)
    @total_credit_transactions = @credit_transactions.sum(:amount)
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = current_user.books.create(book_params)

    respond_to do |format|
      if !@book.new_record?
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:company)
    end
end
