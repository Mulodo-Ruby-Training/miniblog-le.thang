module ApplicationHelper
  def result_info (status = nil,data_object = nil, message = nil)
    hash = {}
    arr = status.to_s.split(',')
    code = arr[0].to_i
    message = message.blank? ? arr[1] : message
    data_object = data_object.present? ? data_object : nil
    hash[:meta] = {code: code, messages: message}
    hash[:data] = data_object
    return hash
  end
end
