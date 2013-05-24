
input_file_path = File.expand_path(File.dirname(__FILE__) + '/data/consolidated-attempt4-core-orderdate-limitafter072012.csv')
notes_temp_file_path = '/tmp/processed_311_notes.txt'

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

transform(:note_type) do |n,v,r|
=begin
  This is rough: just makes type a closure if the current status is closed or
  an activity otherwise (no option for opened presently)
=end
  r[:"Call Status"] == "3" ? "closed" : "activity"
end

transform(:updated_datetime) do |n,v,r|
=begin
  if r[:close_date_calc] == nil
    date = r[:entry_date_calc] + " " + r[:entry_time_calc]
    date.to_datetime.xmlschema
  else
    date = r[:close_date_calc] + " " + r[:close_time_calc]
    date.to_datetime.xmlschema
  end
=end
  ("2013-04-17" + " " + "12:47").to_datetime.xmlschema
end

destination :output_notes, {
  file: notes_temp_file_path
},
{
  order: [:updated_datetime, :"Action Taken Description", :note_type, :"Call ID"]
}

post_process :bulk_import, {
  file: notes_temp_file_path,
  columns: [:datetime, :summary, :type, :request_id],
  target: :development,
  table: 'notes'
}
