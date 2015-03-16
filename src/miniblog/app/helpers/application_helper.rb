module ApplicationHelper
  def result_info (const_status = nil,data_object = nil, message = nil)
    hash = {}
    code = const_status.kind_of?(Array) ? const_status[0] : const_status
    message = message.present? ? const_status[1] : message
    data_object = data_object.present? ? data_object : nil
    hash[:meta] = {code: code, messages: message}
    hash[:data] = data_object
    return hash
  end
end
