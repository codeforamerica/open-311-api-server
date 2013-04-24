
file = File.expand_path(File.dirname(__FILE__) + '/data/sb311sample.csv')

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
  r[:entry_date_calc] + r[:entry_time_calc]
end

transform(:updated_datetime) do |n,v,r|
  "test updated_datetime"
end

destination :out, {
  file: 'processed_311_data.txt',
},
{
  order: [:call_id, :call_status, :call_type_description, :call_type_code, \
    :description, :requested_datetime, :updated_datetime]
}

