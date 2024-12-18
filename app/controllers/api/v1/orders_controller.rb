class Api::V1::OrdersController < Api::V1::ApiController

  def index
    code = params[:establishment_code]
    status = params[:status]

    orders = Order.all.joins(:establishment).where(establishments: { code: code }, status: status)
    
    if status.nil? || status == ""
      orders = Order.all
    end
    
    orders = orders.order(created_at: :desc)
    
    render status: 200, json: orders.as_json(
        except: [:updated_at],
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
        except: [:updated_at],
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

  def update
    order = Order.joins(:establishment)
                  .where(establishments: { code: params[:establishment_code] })
                  .find_by(code: params[:order_code])

    order_status = params["status"]

    if order.update(status: order_status)
      render status: 201, json: order.as_json(
        except: [:updated_at],
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
      render status: 404, json: { error: 'Pedido não atualizado' }
    end
  end

end