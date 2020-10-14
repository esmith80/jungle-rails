class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']

  def show
    # number of products in database
    @product_count = Product.count
    # number of categories in database
    @category_count = Product.select(:category_id).distinct.count

  end
end
