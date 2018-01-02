# README

This Rails app demonstrates the use of the [BibCard](https://github.com/UW-Madison-Library/bibcard) gem.

## Installation

```bash
$ git clone https://github.com/UW-Madison-Library/bibcard-demo
$ cd bibcard-demo
$ bundle install
$ bin/rails s
```

Point your browser at:

* [View a single author card](http://localhost:3000/authors/n78086005)
* [View multiple author cards in a faux library catalog display](http://localhost:3000/catalog/123)

Any Library of Congress Name Authority File (LCNAF) identifier should work for the first link. The latter link will only display bibliographic details for a specific book at the identities associated with it (Gertrude Stein and Pablo Picasso).
