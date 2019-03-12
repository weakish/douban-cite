# douban-cite

A book reference generator. Book information is fetched from [douban](http://www.douban.com).

## Installation

    go get -u github.com/weakish/douban-cite
    
Binaries are provided for amd64 machine and windows/linux/osx/freebsd os.
See [Releases] page.

[Releases]: https://github.com/weakish/douban-cite/releases 

## Usage

```sh
douban-cite ISBN
```

### Example

```sh
; douban-cite 9780262560993
Daniel P. Friedman, Matthias Felleisen. 1995-12-21. The Little Schemer - 4th Edition[M]. The MIT Press. ISBN 9780262560993
```

Note that the output is meant for manual editing afterwards, since Douban does not provide revision and publisher location.

For example, there are two issues in the above example:

`The Little Schemer - 4th Edition[M].` should be:


    The Little Schemer[M]. 4th Edition.

And `The MIT Press.` should be:

    Cambridge, MA: MIT Press
    
## License

0BSD
