class Api::V1::OrdersController < Api::V1::ApiController

  def index
    code = params["establishment_code"]
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

  def show
    order = Order.joins(:establishment)
                 .where(establishments: { code: params[:establishment_code] })
                 .find_by(code: params[:order_code])

    if order
      render status: 200, json: order.as_json(
        only: [:created_at, :name, :status],
        include: {
          order_items: {
            only: [:note],
            include: { 
              orderable: { only: [:name, :description, :calories] },
              portion: { only: [:description, :real, :cent] }
            }
          }
        }
      )
    else
      render status: 404, json: { error: 'Pedido não encontrado' }
    end
  end
end