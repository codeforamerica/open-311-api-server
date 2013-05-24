input_file_path = File.expand_path(File.dirname(__FILE__) + '/data/consolidated-attempt4-core-orderdate-limitafter072012.csv')
requests_temp_file_path = '/tmp/processed_311_requests.txt'

# Use symbolized column headers from the CSV itself, for flexibility if dump structure changes
input_column_headers = CSV.parse(File.open(input_file_path).first)[0]
input_column_headers.map! { |col_name| col_name.to_sym }

source :input,
  {
    file: input_file_path,
    parser: :csv,
    skip_lines: 1
  },
  input_column_headers 

transform(:description) do |n,v,r|
  "test description"
end

transform(:call_status) do |n,v,r|
  r[:"Call Status"] == "3" ? "closed" : "open"
end

transform(:requested_datetime) do |n,v,r|
  date = r[:"Entry Date - Calc"] + " " + r[:"Entry Time - Calc"]
  date.to_datetime.xmlschema
end

transform(:updated_datetime) do |n,v,r|
=begin
  if r[:"Close Date - Calc"] == nil
    date = r[:"Entry Date - Calc"] + " " + r[:"Entry Time - Calc"]
    date.to_datetime.xmlschema
  else
    date = r[:"Close Date - Calc"] + " " + r[:"Close Time - Calc"]
    date.to_datetime.xmlschema
  end
=end
  ("2013-04-17" + " " + "12:47").to_datetime.xmlschema
end

destination :output_requests, {
  file: requests_temp_file_path 
},
{
  order: [:"Call ID", :call_status, :"Call Type Description", :"Call Type Code", :description, :requested_datetime, :updated_datetime]
}

post_process :bulk_import, {
  file: requests_temp_file_path,
  columns: [:service_request_id, :status, :service_name, :service_code, :description, :requested_datetime, :updated_datetime],
  target: :development,
  table: 'requests'
}

