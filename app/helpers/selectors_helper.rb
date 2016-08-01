# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
module SelectorsHelper
  # Returns the full title on a per-page basis.  
  # @param page_title [String]
  # @return [String] Title  
  def full_title(page_title = '')
    base_title = 'ESoOD'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end
end
