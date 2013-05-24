require 'active_support'
require 'pry'

### Change this to point to your file
#input_file_path = File.expand_path('~/Workspace/All_311_Cases.csv')
input_file_path = File.expand_path('~/Downloads/All_311_Cases-KC-shortDateRange-noLocation.csv')

# Do not change
requests_temp_file_path = '/tmp/processed_311_requests.txt'
input_column_headers = CSV.parse(File.open(input_file_path).first)[0]
input_column_headers.map! { |col_name| col_name.to_sym }

source :input,
  {
    file: input_file_path,
    parser: :csv,
    skip_lines: 1
  },
  input_column_headers 



### Change below to map your data to Open311 spec
### For description of fields, review the spec at http://wiki.open311.org/GeoReport_v2#GET_Service_Requests

transform(:service_request_id) do |n,v,r|
  r[:"CASE_ID"]
end

transform(:status) do |n,v,r|
  ### Fill me in, making sure that all rows return either "open" or "closed"
  if r[:"STATUS_CATEGORY"] == "C"
    my_call_status = "closed"
  else
    my_call_status = "open"
  end
  my_call_status
end

transform(:service_name) do |n,v,r|
  r[:"NAME"]
end

transform(:service_code) do |n,v,r|
  r[:"NAME"]
end

transform(:description) do |n,v,r|
  ### Fill me in
  # Example:
  # r[:"Description"]
  # Above would take the value in the Description column of the source CSV and make it the value in the Open311 server
  r[:"CASE_SUMMARY"]
end

transform(:requested_datetime) do |n,v,r|
  ### Fill me in
  ### Make sure you call .to_datetime.xmlschema at the end of whatever the value is to convert it to the right format
  ### as require by the Open311 spec
  # Example:
  #r[:"CREATION_DATE"].xmlschema
  DateTime.strptime(r[:"CREATION_DATE"], '%m/%d/%Y %I:%N:%S %p').to_datetime.xmlschema
end

transform(:updated_datetime) do |n,v,r|
  ### Fill me in
  ### Make sure you call .to_datetime.xmlschema at the end of whatever the value is to convert it to the right format
  ### as require by the Open311 spec
  # Example:
  #r[:"CLOSED_DATE"].xmlschema
  if r[:"CLOSED_DATE"] != nil
    DateTime.strptime(r[:"CLOSED_DATE"], '%m/%d/%Y %I:%N:%S %p').to_datetime.xmlschema
  else
    ""
  end
end


destination :output_requests, {
  file: requests_temp_file_path 
},
{
  order: [:service_request_id, :status, :service_name, :service_code, :description, :requested_datetime, :updated_datetime]
}

post_process :bulk_import, {
  file: requests_temp_file_path,
  columns: [:service_request_id, :status, :service_name, :service_code, :description, :requested_datetime, :updated_datetime],
  target: :development,
  table: 'requests'
}

