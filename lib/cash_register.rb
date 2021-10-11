require 'pry'
require 'securerandom'

class CashRegister
    attr_reader :discount
    attr_accessor :total, :transactions

    def initialize(discount = 20)
        @total = 0.0
        @transactions = []
        @discount = discount.to_f
    end

    def add_item(title, price, quantity = 1)
        id = SecureRandom.uuid
        quantity.times do
            self.transactions << { name: title, price: price, id: id }
        end
        self.total += price * quantity
    end

    def apply_discount
        self.total = self.total - (self.discount/100 * self.total)
        if self.total.zero?
            'There is no discount to apply.'
        else
            "After the discount, the total comes to $#{self.total.to_i}."
        end
    end

    def items
        transactions.collect { |item| item[:name]}
    end

    def void_last_transaction
        id_to_remove = transactions.last[:id]
        puts id_to_remove
        pp transactions
        self.transactions = transactions.select { |transaction| transaction[:id] == id_to_remove}
        pp transactions
        if self.transactions.empty?
            self.total = 0.0
        elsif
            self.total = transactions.sum {|transaction| transaction[:price]}
        end
         
    end
end