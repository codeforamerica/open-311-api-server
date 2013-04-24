
file = File.expand_path(File.dirname(__FILE__) + '/data/sb311sample.csv')
requests_temp_file = '/tmp/processed_311_requests.txt'
notes_temp_file = '/tmp/processed_311_notes.txt'

source :input,
  {
    file: file,
    parser: :csv,
    skip_lines: 1
  },
  [
    :call_id,
    :call_status,
    :call_type_code,
    :call_type_description,
    :entry_date_calc,
    :entry_time_calc,
    :action_taken_description,
    :close_date_calc,
    :close_time_calc,
    :elapsted_time
  ]

transform(:description) do |n,v,r|
  "test description"
end

transform(:call_status) do |n,v,r|
  r[:call_status] == "3" ? "open" : "closed"
end

transform(:requested_datetime) do |n,v,r|
  date = r[:entry_date_calc] + " " + r[:entry_time_calc]
  date.to_datetime.xmlschema
end

transform(:updated_datetime) do |n,v,r|
  if r[:close_date_calc] == ""
    date = r[:entry_date_calc] + " " + r[:entry_time_calc]
    date.to_datetime.xmlschema
  else
    date = r[:close_date_calc] + " " + r[:close_time_calc]
    date.to_datetime.xmlschema
  end
end

destination :output_requests, {
  file: requests_temp_file 
},
{
  order: [:call_id, :call_status, :call_type_description, :call_type_code, :description, :requested_datetime, :updated_datetime]
}
#destination :output_notes {
#  file: notes_temp_file
#},
#{
#order: [:updated_datetime, :call_type_description]
#}

post_process :bulk_import, {
  file: requests_temp_file,
  columns: [:service_request_id, :status, :service_name, :service_code, :description, :requested_datetime, :updated_datetime],
  target: :development,
  table: 'requests'
}


