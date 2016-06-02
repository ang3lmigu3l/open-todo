class Api::ListsController< ApiController
 before_action :authenticated?

  def create
    user = User.find(params[:user_id])
    list = user.lists.new(lists_params)

    if list.save
      render json: list
    else
      render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      list = List.find(params[:id])
      list.destroy

      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotFound
     render :json => {}, :status => :not_found
    end
  end


private

  def lists_params
    params.require(:list).permit(:name,:permissions)
  end
end
