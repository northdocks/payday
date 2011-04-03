module Payday
  # Represents a line item in an invoice.
  #
  # +quantity+ and +price+ are written to be pretty picky, primarily because if we're not picky about what values are set to
  # them your invoice math could get pretty messed up. It's recommended that both values be set to +BigDecimal+ values.
  # Otherwise, we'll do our best to convert the set values to a +BigDecimal+.
  class LineItem
    include LineItemable

    attr_accessor :description, :quantity, :price, :currency

    # Initializes a new LineItem
    def initialize(options = {})
      self.currency = options[:currency]
      self.price = options[:price] || Money.new(0, currency)
      self.quantity = options[:quantity] || "1"
      self.description = options[:description] || ""
    end

    def currency
      price.try(:currency) || @currency || Payday::Config.default.currency
    end

    # Sets the quantity of this {LineItem}
    def quantity=(value)
      @quantity = BigDecimal.new(value.to_s)
    end

    # Sets the price for this {LineItem}
    def price=(value)
      case value
      when Money
        @price = value
      else
        @price = Money.new(value, currency)
      end
    end
  end
end