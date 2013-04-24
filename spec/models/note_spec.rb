require 'spec_helper'

describe Note do
  it "should be created with a Request gracefully" do    
    @r = Request.create service_request_id: "1234", status: "open", service_name: "garbage", service_code: "GARB", \
      description: "someone left shit on my lawn", requested_datetime: "2013-04-01 10:48".to_datetime
    @r.notes.create datetime: "2013-04-01 10:48".to_datetime, type: "activity", summary: "Sent to AEP"
    @r.notes.count.should eq(1)
  end
end
