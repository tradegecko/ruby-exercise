class DreamScopeApi::RemoteImage
  RETRY_IN = 30.seconds
  TIMEOUT_IN = 300.seconds

  def initialize(remote_id)
    @remote_id = remote_id
    @status_check_attempt_count = 0
  end

  def result
    loop do
      return remote_image if completed?
      fail('Taking too long') if taking_too_long?
      @status = nil
      sleep_before_retry
    end
  end

  private

  def check_url
    [DreamScopeApi::BASE_URL, @remote_id].join('/')
  end

  def status
    @status ||= JSON.parse(RestClient.get(check_url))
  end

  def completed?
    status['processing_status'].nonzero?
  end

  def taking_too_long?
    (@status_check_attempt_count * RETRY_IN) > TIMEOUT_IN
  end

  def remote_image
    RestClient.get(status['filtered_url'])
  end

  def sleep_before_retry
    sleep RETRY_IN unless Rails.env.test?
  end
end
