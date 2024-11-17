class Api::V1::OrdersController < Api::V1::ApiController
  def index
    code = params["code"]
    status = params["status"]
    
    if status.nil? || status == ""
      orders = Order.all
    else
      orders = Order.all.joins(:establishment).where(establishment: { code: code }, status: status)
    end
    
    render status: 200, json: orders.as_json(
        except: [:created_at, :updated_at],
        include: {
          establishment: {only: [:brand_name, :code]},
          order_items: {
            only: [:note],
            include: { 
              orderable: { only: [:name, :description, :calories] },
              portion: { only: [:description, :real, :cent] }
            }
          }
        }
      )
  end
end