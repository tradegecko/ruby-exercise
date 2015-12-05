class DeepDreamJob < ActiveJob::Base
  queue_as :default
  
  def perform
    # perform dreaming job later
    puts "performing dreaming job"
  end
end
