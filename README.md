# El Dorado

This app is used to calculate the number of trips/number of ships needed to exactly carry a given weight of gold. 


## Dependencies

- Rails 5, but 4 should work as well.
- Puma, or you can substitute your own server

## Setup

`rake db:migrate` to create your databases
`rails dev:cache` if you're running in development mode and want to cache the lookup table
`rails s` to run the server

## Sample Usage

- Create some ships. Every ship listed in the fleet will be used in the calculations. 
- Use the fleet calculator to generate a trip manifest of number of each ship/number of trips per ship needed for the trip.

## Tests

`rspec spec`

## Known Limitations

- Limited to fleet sizes/trip sizes of less than 10 per ship class
- Having more than 6 ship classes in the fleet will cause the initial calculation to be quite slow. May need to consider refactoring the preprocessing step into a background job.

