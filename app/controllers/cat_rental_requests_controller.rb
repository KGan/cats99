class CatRentalRequestsController < ApplicationController
  before_action :is_owner?, only: [:approve, :deny]

  def index
    @cat_requests = Cat.find(params[:cat_id]).cat_rental_requests
    render :index
  end

  def create
    merged_params = rental_params.merge({user_id: current_user.id})
    @cat_rental = CatRentalRequest.new(merged_params)
    if @cat_rental.save
      redirect_to rental_url(@cat_rental)
    else
      flash[:create_error] = @cat_rental.errors.full_messages
      redirect_to new_rental_url
    end
  end

  def new
    @cat_rental = CatRentalRequest.new(cat_id: 0,
                                       start_date: Date.tomorrow,
                                       end_date: Date.tomorrow.tomorrow
                                       )

    @cat_id = params[:cat_id]
    render :new
  end

  def edit
    render :edit
  end

  def show
    @cat_rental = CatRentalRequest.find(params[:id])
    if @cat_rental
      redirect_to cat_url(@cat_rental.cat)
    else
      flash[:cat_not_found] = "Request not found"
      redirect_to cats_url
    end
  end

  def update

  end

  def destroy
  end

  def approve
    @request = CatRentalRequest.find(params[:id])
    @request.approve!
    redirect_to :back
  end

  def deny
    @request = CatRentalRequest.find(params[:id])
    @request.deny!
    redirect_to :back
  end

  private
    def rental_params
      params.require(:rental).permit(:cat_id, :start_date, :end_date)
    end

    def is_owner?
      request = CatRentalRequest.find(params[:id])
      if !request.is_owner?(current_user.id)
        redirect_to :back
      end
    end
end
