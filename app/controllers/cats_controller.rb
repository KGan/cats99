class CatsController < ApplicationController
  before_action :owns_cat?, only: [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    render :new
  end

  def edit
    @cat = Cat.find(params[:id])

  end

  def create
    merged_params = cat_params.merge({user_id: current_user.id})
    @cat = Cat.new(merged_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash[:create_failed] = @cat.errors.full_messages
      redirect_to new_cat_url
    end
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash[:update_failed] = @cat.errors.full_messages
      redirect_to edit_cat_url
    end
  end

  def destroy
    @cat = Cat.find(params[:id])
    if @cat
      @cat.destroy
      render @cat
    else
      redirect_to cats_url
    end
  end

  private
    def cat_params
      params.require(:cat).permit(:name, :sex, :birth_date, :color, :description)
    end

    def owns_cat?
      @cat = Cat.find(params[:id])
      if current_user.id != @cat.user_id

        redirect_to cats_url
      end
    end
end
