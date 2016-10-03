# Point of Service APP

* [api](https://github.com/fedeaux/pos-api)
* [webapp](https://github.com/fedeaux/pos-webapp)

## Running the API Locally

Assuming you already have ruby and bundler installed.

     $ cd /path/to/pos-api
     $ bundle install

Bundle should warn you about missing system packages, like mysql or QT, read the warns and follow the instructions.

Rename the .env.example file to .env, edit it according to your local requirements, and run

     $ rake db:setup && rake db:setup RAILS_ENV=test
     $ rake db:migrate && rake db:migrate RAILS_ENV=test

To create you local databases. And then run

     $ rails server -p 3001

To start the server on http://localhost:3001.

You may want to start with some data, to do so, run: (it takes a while)

    $ rake db:seed

It will create an user, some waiters, products, categories, tables and consumption data.

The user is created with password 'defaultpassword' and email charles@ray.
The user signup isn't implemented. You can create new users through the console.

    $ rails console

```ruby
> User.create email: 'someemail@example.com', password 'mypassword', password_confirmation: 'mypassword'
```

### Running Tests

    $ rspec spec

To view a coverage report, open coverage/index.html. (Created with simplecov gem)

## Running the WEBAPP Locally
Assuming you already have ruby and bundler installed.

     $ cd /path/to/pos-webapp
     $ bundle install

Rename the .env.example file to .env, by default, it sets the API_URL to http://localhost:3001. You need to edit this file only if you plan to run the API in a different address than the one we set in the previous step.

## Assumptions

* User management is not a requirement

* During the checkout, the payment doesn't need to match the sum of the prices of every item. If the payment is above the value, it is considered a tip (tables can be assigned waiters), if the payment is below the value, it is considered a discount. There is no way to give a discount AND a tip.

* Requests specs are enough to test the controllers as a by-product. More complex apps would require controller specs as well.

* This is not a multitenant software, meaning every installation can deal with a single restaurant.

## Things I wish I could have implemented

* The reports are generated on every request. If I had more time, I would like to cache their results and warn the user about when this report was generated, giving the option to force the generation again. Also, the report is generated within the request, which is bad, because it may timeout. If I had more time I would create an activejob task to create the report and perhaps use a channel to tell the user that the report has been generated.

* Better validations. For example, the system allows a report to be created with the start after the finish, leading to an empty set of consumptions

* Front-end notifications about backend validation errors.

* Overall better UI. I started trying to make the app really nice, but I realized that the time wasn't enough.

## About this test

Well, I believe I can be honest here: I think this kind of test is really boring.
You know, every job I've applied to ask for this kind of "very basic" test. They are not challenging, but demand a lot of time, and almost anyone could have done them and feel like I'm feeling: "I could do so much better...".

Also I have a lot of similar toy projects (with better ideas and design) that I not only could, but would love to show without spending time and with better results. I think giving the option for us to show any project would be nice.

If I were to apply this kind of test, I would give a basic (or even complex) system and ask for more challenging tasks like:
* The notification system implemented has grown organically and needs a refactor. Please refactor it in order to DRY it up and make it more modular.

* Make the message system real-time.

* There is leak of security on the "promote to admin" feature, allowing malicious requests to promote customers to admin. Find and correct it, writing specs that address this issue.

* Create one pull request for each one of these tasks at "some private github repo"
