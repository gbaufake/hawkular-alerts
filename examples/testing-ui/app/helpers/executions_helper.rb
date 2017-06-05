module ExecutionsHelper

def has_body?(execution)
  case @test_case.http_method
  when 'POST'
    return true
  when 'PUT'
    retrun true
  else
    return false
  end
  end
end
