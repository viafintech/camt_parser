# CamtParser

![Travis Build state](https://api.travis-ci.org/Barzahlen/camt_parser.svg)

CamtParser is a Ruby Gem which does some basic parsing of camt052 and camt053 files into an object
structure for easier usability instead of having to use an XML parser all the time.
Keep in mind that this might not include a complete parsing of camt specification.
Fields that we did not need for our use-cases are simply ignored for now.

## Getting started

1. add the Gem to the Gemfile

        gem 'camt_parser'

2. Require the Gem at any point before using it
3. Use it!

## Example camt053
```ruby
camt = CamtParser::File.parse path_to_file
puts camt.group_headers.creation_date_time
camt.statements.each do |statement|
    puts statement.account.iban
    statement.entries.each do |entry|
        # Access individual entries/bank transfers
        puts entry.amount
        puts entry.debitor.iban
    end
end
```

Please check the code for fields not mentioned here.

## Bugs and Contribution
For bugs and feature requests open an issue on Github. For code contributions fork the repo, make your changes and create a pull request.

### License
[LICENSE](LICENSE)
