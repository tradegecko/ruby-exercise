class DeepDreamer

  def self.dream
    DeepDreamJob.perform_later
  end
  
end
