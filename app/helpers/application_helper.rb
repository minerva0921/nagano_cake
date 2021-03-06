module ApplicationHelper
  def full_name(customer)
    customer.last_name + customer.first_name
  end

  def full_address(key)
    "#{key.postal_code}#{key.address}"
  end

  def current_cart
    @cart_items = current_customer.cart_items
  end

  # 小計の計算
  def sub_price(sub)
    sub.item.tax_in_price * sub.amount
  end

  # 合計金額の計算
  def total_price(totals)
    price = 0
    totals.each do |total|
      price  +=  sub_price(total)
    end
    return price
  end


  def billing(order)
    total_price(current_cart) + order.postage
  end

end
