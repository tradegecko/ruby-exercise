require 'rails_helper'

RSpec.describe FileHandler do
  let(:file_name) { "tradegecko-signup-logo@2x-e56f19c66b56c6a1494105f053bfc9fc9505e837fc6189402d68e6dea74f6091.png" }
  let(:file_path) { FileHandler.download_file_from_url "https://d3h6ue1fvxa32i.cloudfront.net/assets/tradegecko-signup-logo@2x-e56f19c66b56c6a1494105f053bfc9fc9505e837fc6189402d68e6dea74f6091.png" }

  describe "#download_file_from_url" do
    it "download the picture from url and turn the file path" do
      file_path.should include("public/tradegecko-signup-logo@2x-e56f19c66b56c6a1494105f053bfc9fc9505e837fc6189402d68e6dea74f6091.png")
    end
  end
end
