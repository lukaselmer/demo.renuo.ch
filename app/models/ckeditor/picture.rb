class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    :path => '/:class/:attachment/:id_partition/:style/:filename',
                    :storage => :s3,
                    :s3_credentials => {
                      :bucket => ENV['S3_BUCKET_NAME'],# Figaro.env.s3_bucket_name,
                      :access_key_id => ENV['AWS_ACCESS_KEY_ID'], # Figaro.env.aws_access_key_id,
                      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'] # Figaro.env.aws_secret_access_key
                    },
                    :styles => { :content => '800>', :thumb => '118x100#' }

  validates_attachment_size :data, :less_than => 2.megabytes
  validates_attachment_presence :data

  def url_content
    url(:content)
  end
end
