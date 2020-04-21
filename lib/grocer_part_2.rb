require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |cart_item|
    #find if there is any elligible coupon for the item
    coupon_to_be_applied = coupons.find{|x| x[:item] == cart_item[:item]}
    
    if(coupon_to_be_applied)
      #see how many times can we apply the coupon
      times_applicable = cart_item[:count] / coupon_to_be_applied[:num]
      if (times_applicable > 0)
        cart_item_with_coupon =  {
          :item => cart_item[:item] + " W/COUPON",
          :price => coupon_to_be_applied[:cost]/coupon_to_be_applied[:num],
          :clearance => cart_item[:clearance],
          :count => coupon_to_be_applied[:num] * times_applicable
        }
        cart_item[:count] = cart_item[:count] - cart_item_with_coupon[:count]
        cart.push(cart_item_with_coupon)
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |cart_item|
    if(cart_item[:clearance])
      cart_item[:price] = (cart_item[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  consolidated_cart = consolidate_cart(cart)
  consolidated_cart_coupons_applied = apply_coupons(consolidate_cart,coupons)
  consolidated_cart_all_discounts_applied = apply_clearance(consolidated_cart_coupons_applied)
  subtotal = consolidated_cart_all_discounts_applied.reduce(0){|total,cart_item| total + (cart_item[:count]*cart_item[:price])}
  total = (subtotal > 100 ? subtotal* 0.9 : subtotal)
end
