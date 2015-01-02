# douban-cite

[![Gem Version](https://badge.fury.io/rb/douban-cite.svg)](http://badge.fury.io/rb/douban-cite)

A book reference generator. Book information is fetched from [douban](http://www.douban.com).

## Installation

    $ gem install douban-cite

## Usage

```sh
douban-cite ISBN_OR_DOUBAN_ID
```

### Example

```sh
; douban-cite 9780262560993
Daniel P. Friedman, Matthias Felleisen. 1995-12-21. The Little Schemer - 4th Edition[M]. Th: The MIT Press. ISBN 9780262560993
```

Note that the output is meant for manual editing afterwards, since Douban does not provide revision and publisher location.

For example, there are two issues in the above example:

`The Little Schemer - 4th Edition[M].` should be:


    The Little Schemer[M]. 4th Edition.

And `Th: The MIT Press.` should be:

    Cambridge, MA: MIT Press

(`Th` is a silly guess, which may be useful for some Chinese publisher.)


### As a library

You can also use it as a library:

```ruby
require 'douban-cite'

Douban::Cite.convert_to_ref(Douban::Cite.get_book_info(id))
```

## Contributing

1. Fork it ( https://github.com/weakish/douban-cite/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
