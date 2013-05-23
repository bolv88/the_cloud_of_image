module ImagesHelper
  def file_size(size)
    size = size.to_i
    if size > 1000*1000
      (size / (1000*1000.0)).round(2).to_s+" M"
    elsif size > 1000
      (size / 1000.0).round(2).to_s+" K"
    else
      size.to_s + " B"
    end
  end
end
