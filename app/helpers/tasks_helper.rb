module TasksHelper
  def sortable(column, title)
    if params[:sort] == "#{column}_desc"
      direction = "#{column}_asc"
    else
      direction = "#{column}_desc"
    end

    link_to title, tasks_path(:sort => direction)
  end
end
