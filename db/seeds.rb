# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Request.create! service_request_id: "1234", status: "open", service_name: "garbage", service_code: "GARB", description: "someone left shit on my lawn", requested_datetime: "1/2/12 00:00:00".to_datetime
