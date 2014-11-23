class CheckHistory < ActiveRecord::Base
  
  # Get id of last tweet checked from db
  def self.last_id
    if(self.count == 0)
      return nil
    else
      return self.first.last_id_checked
    end
  end

  # Set the last tweet checked
  def self.set_last_id(id)
    if(self.count == 0)
      self.create(last_id_checked:id)
    else
      self.first.update(last_id_checked:id)
    end
  end
  
end
