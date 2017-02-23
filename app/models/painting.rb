class Painting < ActiveRecord::Base
  
  
  def uploaded_picture=(picture_field)
    #render_text picture_field.inspect
    if picture_field != ""
      self.image_name = base_part_of(picture_field.original_filename)
      self.content_type = picture_field.content_type.chomp
      self.image_data = picture_field.read
    end
  end
  
  def base_part_of(file_name)
    File.basename(file_name).gsub(/[^\w._-]/, '')
  end
  
  validates_numericality_of :width, :height, :price
  
  validates_presence_of :painting_name, :material#, :image_data#, :message => "--you can't leave these fields blank"
  
  validates_format_of :content_type, :with => /^image/, :message => "--you can only upload pictures"
  
  def validate
    errors.add(:price, "--the price isn't valid.") unless price.nil? || (price > 0)
    errors.add(:width, "--the painting width isn't valid.") unless width.nil? || (width > 0)
    errors.add(:height, "--the painting height isn't valid.") unless height.nil? || (height > 0)
  end
  
  
  def get_painting2xxx(response)
      #@entry = Person.find(@params['id'])
      response.headers['Pragma'] = ' '
      response.headers['Cache-Control'] = ' '
      response.headers['Content-type'] = 'application/octet-stream'
      #response.headers['Content-Disposition'] = "attachment; filename=#{self.image_name}" 
      response.headers['Content-Disposition'] = "attachment; filename=#{self.image_name}; inline" 
      response.headers['Accept-Ranges'] = 'bytes'
      response.headers['Content-Length'] = self.image_data.length
      response.headers['Content-Transfer-Encoding'] = 'binary'
      response.headers['Content-Description'] = 'File Transfer'
      render :text => self.image_data
      #render_text self.image_data
  end
  
  #@max_height = 135
  #@max_width = 165
  def get_thumbnail_height
    return 135
    max_size_pixels = 165
    
    if self.width > self.height
      ratio = self.width.to_f/self.height.to_f
      return (max_size_pixels/ratio).to_i    
    end
    
    return max_size_pixels
  end
  
  def get_thumbnail_width
    return 165
    max_size_pixels = 165
    #max_height = 135
    #max_width = 165
    
    if self.height > self.width
      ratio = self.height.to_f/self.width.to_f      
      return max_size_pixels/ratio      
    end
    
    return max_size_pixels
  end
  
  

  
end
