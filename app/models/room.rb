class Room < ActiveRecord::Base
  def url
    " -c #{self.name} -k #{self.password} -f -l 121.41.205.157:4546 "
  end
end
