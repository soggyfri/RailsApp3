module ApplicationHelper

  def title
    base_title = "Test App"
    if @micropost.nil?
      base_title
    else
       @micropost 
    end
  end

end
