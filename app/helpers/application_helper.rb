module ApplicationHelper

  def title
    base_title = "Uconn::Facebook"
    if @micropost.nil?
      base_title
    else
       @micropost 
    end
  end

end
