Open 311 API Server
======
A simple Rails app to transform and serve service request data ("311 data") in the Open311 spec, making it easier for cities to redeploy apps based on Open311.

Getting Involved
-----
This app is in early alpha. To learn more or contribute, leave a comment on GitHub Issues or shoot a tweet over to Dave Guarino [@allafarce](https://twitter.com/allafarce).

The *best* way to get involved is to provide links to your city's service request (311) data, if they make it available. Please add these via a GitHub Issue for now.

Installation
-----

### Dependencies

This is a Ruby on Rails app. It depends on:

* Ruby (developed on version 1.9.3)
* PostgreSQL (database)
* Ruby gems included in the Gemfile (run `bundle install` to install these)

### Getting started

This project essentially has two components:

* A Rails server to server "just enough data" in the Open311 spec to make deploying Open311 apps feasible.

* Extract/Transform/Load (ETL) scripts built using the [ActiveWarehouse-ETL gem](http://activewarehouse.info/). Current example scripts can be found in /etl/ and are organized by city name.

The workflow for getting started, therefore, is:

1. Clone the repo
2. Download a city's service request data
3. Create a new directory for your city, and copy the Kansas City `load-requests.ctl` file into your city directory (it is the best example to date)
4. Edit that file following the instructions in comments to extract, transform, and load data for your city
5. Run `rails s` to launch the Open311 API server, and open your browser to [http://localhost:3000/requests.json](http://localhost:3000/requests.json) to see if it's working
6. Set up an Open311 app, and point it at your Open311 server to see if it's working

If you successfully get it working for your city, definitely submit a pull request with your script!

Deployment
-----

This app has been successfully deployed on Heroku for beta-testing purposes only. However, running the ETL scripts to process the data (see /etl/) was done locally, and then the `pg_dump` utility in Postgres  was used in concert with Heroku's Postgres backup loading ability to load the (already transformed and Postgressified) data. For now this is the recommended approach. (Please add an Issue if you have other successful deployments.)

Copyright & License
-----
Copyright (c) 2013 Code for America Laboratories.

See LICENSE.mkd for details.

[![Code for America Tracker](http://stats.codeforamerica.org/codeforamerica/cfa_template.png)](http://stats.codeforamerica.org/projects/cfa_template)

