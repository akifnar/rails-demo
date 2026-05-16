require "ostruct"

class Pago
  def self.make_payment(order_id:, payment_method:, payment_details:)
    case payment_method
    when :check
      Rails.logger.info "Processing check: " +
        payment_details.fetch(:routing).to_s + "/" +
        payment_details.fetch(:account).to_s
    when :credit_card_number
      Rails.logger.info "Processing credit_card: "  +
        payment_details.fetch(:cc_num).to_s + "/" +
        payment_details.fetch(:expiration_month).to_s + "/" +
        payment_details.fetch(:expiration_year).to_s
    when :po_number
      Rails.logger.info "Processing purchase order: " +
        payment_details.fetch(:po_num).to_s
    else
      raise "Unknown payment_method #{payment_method}"
    end
    sleep 3 unless Rails.env.test?

       if rand(3) % 2 == 0
        Rails.logger.info "Done Processing Payment"
        OpenStruct.new(succeeded?: true)
       else
        Rails.logger.info "Failed Processing Payment"
        OpenStruct.new(succeeded?: false)
       end
  end
end
