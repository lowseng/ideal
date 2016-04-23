module ApplicationHelper
  
  def gravatar_for(user, options = { size: 80})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.email, class: "img-circle")
  end
  
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Setup Routes Using Ruby On Rails Sample App"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end  

end
