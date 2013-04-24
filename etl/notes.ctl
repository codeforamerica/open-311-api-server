
file = File.expand_path(File.dirname(__FILE__) + '/data/consolidated-attempt4-core-orderdate-limitafter072012.csv')
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

transform(:note_type) do |n,v,r|
=begin
  This is rough: just makes type a closure if the current status is closed or
  an activity otherwise (no option for opened presently)
=end
  r[:call_status] == "3" ? "closed" : "activity"
end

transform(:call_status) do |n,v,r|
  r[:call_status] == "3" ? "closed" : "open"
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
  file: notes_temp_file
},
{
  order: [:updated_datetime, :action_taken_description, :note_type, :call_id]
}

post_process :bulk_import, {
  file: notes_temp_file,
  columns: [:datetime, :summary, :type, :request_id],
  target: :development,
  table: 'notes'
}
