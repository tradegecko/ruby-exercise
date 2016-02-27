
class RequestStatus
  attr_accessor :status, :message

  def initialize(status=false, message='')
    @status = status
    @message = message
  end
end