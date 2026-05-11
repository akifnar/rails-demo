class ProductsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "products"
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
