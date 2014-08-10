class Transaction < ActiveRecord::Base
  scope :debit, -> { where(entry: 'dr') }
  scope :credit, -> { where(entry: 'cr') }
  scope :period, -> (start_date, end_date) { where("transacted_at BETWEEN ? AND ?", start_date, end_date) }

  ENTRIES = ["cr", 'dr']
  CURENCIES = ["myr", "usd", "sgd"]

  belongs_to :user
  belongs_to :book

  validates :entry, presence: true
  validates :item, presence: true
  validates :amount, presence: true
  validates :currency, presence: true
  validates :transacted_at, presence: true
  validates :transaction_method, presence: true
  validates :user_id, presence: true
  validates :book_id, presence: true

  def debit?
    entry == 'dr'
  end

  def credit?
    entry == 'cr'
  end

end
