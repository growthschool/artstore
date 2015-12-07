class Pay2goService

  def initialize(order)
    @order = order
    @timestamp = order.created_at.to_i
    #@merchant_order_no = "#{order.id}s32"
    @merchant_order_no = gen_order_no
    @total_price = order.total
  end

  def check_value
    d = Digest::SHA256.hexdigest(url_params).upcase
  end

  def url_params
    "HashKey=#{Pay2go.hash_key}&Amt=#{@total_price}&MerchantID=#{Pay2go.merchant_id}&MerchantOrderNo=#{@merchant_order_no}&TimeStamp=#{@timestamp}&Version=1.1&HashIV=#{Pay2go.hash_iv}"
  end

  def gen_order_no
    "#{@order.id}_#{Date.today.to_time.to_i}"
    #{}"#{@order.id}s32"
  end
end
