# AttrSplitter

Split an attribute into multiple virtual attributes, and use a new FormBuilder method called multi_text_field to allow users to enter a long field in individual pieces. Useful for fields with discrete break points, like social security numbers or phone number.

## Usage

Say you have a User class with a phone number attribute that you want to split up into area code | three digits | four digits on the user signup form. Add the following to your model:

    attr_splitter :phone_number, prefixes: [ :first, :second, :third ]

In your form, replace

    f.text_field :phone_number

with

    f.multi_text_field :phone_number, fields: { first: 3, second: 3, third: 4 }

The value of each item in the fields hash specifies the max character length allowed for that field.

## Installation

Add this line to your application's Gemfile:

    gem 'attr_splitter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install attr_splitter

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
