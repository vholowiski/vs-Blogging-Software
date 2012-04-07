class BlogImage < ActiveRecord::Base
has_attached_file :image,
    :styles => {:bs_thumb => ["360x268#", :jpg], 
                :bs_med_thumb => ["260x180#", :jpg],
                :bs_small_thumb => ["160x120#", :jpg]
                }
  #validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes, :message => 'file size maximum 5 MB allowed'
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/pjpeg', 'image/x-png']
end
