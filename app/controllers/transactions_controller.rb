class TransactionsController < ApplicationController
  before_action :authorize

  def new
    @book = Book.find(params[:book_id])
    @transaction = Transaction.new
  end

  def create
    @book = Book.find(params[:book_id])
    transaction_attributes = transaction_params.merge({ user_id: current_user.id })
    @transaction = @book.transactions.create(transaction_attributes)
    if !@transaction.new_record?
      redirect_to @book, notice: "Added transaction!"
    else
      render 'new'
    end
  end

  def show
    @book = Book.find(params[:book_id])
    @transaction = Transaction.find(params[:id])
  end

  def edit
    @book = Book.find(params[:book_id])
    @transaction = Transaction.find(params[:id])
  end

  def update
    @book = Book.find(params[:book_id])
    @transaction = Transaction.find(params[:id])

    if @transaction.update(transaction_params)
      redirect_to book_transaction_path(@book, @transaction), notice: "Updated transaction!"
    else
      render 'edit'
    end
  end

  def destroy

  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def transaction_params
    params.require(:transaction).permit(:entry, :item, :amount, :currency, :transaction_method, :transacted_at, :receipt_url, :notes)
  end

end
