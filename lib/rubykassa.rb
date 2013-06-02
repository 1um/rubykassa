require "rubykassa/engine"
require 'rubykassa/client'
require 'rubykassa/payment_interface'
require 'rubykassa/notification'

module Rubykassa
  extend self

  def configure &block
    Rubykassa::Client.configure &block
  end

  %w(login first_password second_password mode).map do |name|
    define_method name do
      Rubykassa::Client.configuration.send(name)
    end
  end

  def pay_url invoice_id, total, params
    Rubykassa::PaymentInterface.new do
      self.total      = total
      self.invoice_id = invoice_id
      self.params     = params
    end.pay_url
  end
end
