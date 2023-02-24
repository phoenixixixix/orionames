class Admin::SelectionsController < Admin::AdminController
  before_action :set_selection, only: %i[edit update destroy]

  def index
    @selections = Selection.order(created_at: :desc)
  end

  def new
    @selection = Selection.new
  end

  def create
    @selection = Selection.new(selection_params)
    @selection.ids_to_names_hash

    if @selection.save
      redirect_to admin_selections_path, notice: "Selection was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @selection.assign_attributes(selection_params)
    @selection.ids_to_names_hash

    if @selection.save
      redirect_to admin_selections_path, notice: "Selection was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @selection.destroy
    redirect_to admin_selections_path, notice: "Selection was successfully destroyed."
  end

  private

  def set_selection
    @selection = Selection.find(params[:id])
  end

  def selection_params
    params.require(:selection).permit(:title, :post_id, :pinned, names: [])
  end
end
