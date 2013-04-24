
file = File.expand_path(File.dirname(__FILE__) + '/data/sb311sample.csv')
temp_file = '/tmp/processed_311_data.txt'

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

transform(:requested_datetime) do |n,v,r|
  date = r[:entry_date_calc] + " " + r[:entry_time_calc]
  date.to_datetime.xmlschema
end

transform(:updated_datetime) do |n,v,r|
  date = r[:entry_date_calc] + " " + r[:entry_time_calc]
  date.to_datetime.xmlschema
end

destination :out, {
  file: temp_file 
},
{
  order: [:call_id, :call_status, :call_type_description, :call_type_code, :description, :requested_datetime, :updated_datetime]
}

post_process :bulk_import, {
  file: temp_file,
  columns: [:service_request_id, :status, :service_name, :service_code, :description, :requested_datetime, :updated_datetime],
  target: :development,
  table: 'requests'
}


