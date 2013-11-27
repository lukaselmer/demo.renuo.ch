class Ckeditor::AttachmentFile < Ckeditor::Asset
  has_attached_file :data,
                    :path => '/:class/:attachment/:id_partition/:style/:filename',
                    :storage => :s3,
                    :s3_credentials => {
                        :bucket => Figaro.env.s3_bucket_name,
                        :access_key_id => Figaro.env.aws_access_key_id,
                        :secret_access_key => Figaro.env.aws_secret_access_key
                    }

  validates_attachment_size :data, :less_than => 100.megabytes
  validates_attachment_presence :data

  def url_thumb
    @url_thumb ||= Ckeditor::Utils.filethumb(filename)
  end
end
