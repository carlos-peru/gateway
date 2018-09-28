# Installation

```
bundle install
rails server
```

The app will run in [http://localhost:3000](http://localhost:3000)

See a sample: [http://localhost:3000/recipes/search?query=omelet&page1](http://localhost:3000/recipes/search?query=omelet&page1)

# Software Design

This is a rest api that has one endpoint:

```
http://localhost:3000/recipes/search?query=STRING_VALUE&page=INTEGER_VALUE
```

This endpoint requires 2 query parameters:

- query - a string value
- page - an integer value

Otherwise, it will return an error response (http 400).

A sample response body:

```
[{"title":"Baked Omelet","href":"http://www.recipezaar.com/Baked-Omelet-With-Broccoli-Tomato-325014","ingredients":"milk, cottage cheese, broccoli","thumbnail":"http://img.recipepuppy.com/123889.jpg"},{"title":"Mild Curry Omelet","href":"http://allrecipes.com/Recipe/Mild-Curry-Omelet/Detail.aspx","ingredients":"coriander, cumin, turmeric","thumbnail":""},{"title":"Italian Omelet","href":"http://www.recipezaar.com/Light-Italian-Feta-Omelet-281901","ingredients":"egg substitute, feta cheese, basil, roma tomato, salt","thumbnail":"http://img.recipepuppy.com/36027.jpg"}]
```

# Setup

- ruby (2.5.1)
- rails (5.2.1)
- rspec (3.8)

# Implementation

The app was implemented using Ruby on Rails in API only mode to avoid extra middleware irrelevante for the purpose of a REST api. The main components of the app are:

- The recipes controller that handles the request and response
- The recipe service that fetches the data from the 3-party api and returns a list of objects to the controller. The service also uses in-memory caching to avoid unnecessary calls. Note that this was only implemented for the development environment. For production, I would add memecached or redis to handle the in-memory caching.
- The recipe model which is a PORO because we don't store any data in the database.
- The recipe search model which iincludes ActiveModel because it's used to validate the required query parameters in the requests url.

# Tests

There are specs implemented to cover the search action in the recipes controller. Please run the tests with the following command:

```
 bundle exec rspec spec
```

# Dependencies

- [Faraday](https://github.com/lostisland/faraday) for http requests.
- [RSpec](https://github.com/rspec/rspec-rails)
- [factory_bot](https://github.com/thoughtbot/factory_bot)
- [Faker](https://github.com/stympy/faker)
