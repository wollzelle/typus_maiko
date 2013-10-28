# typus_maiko

Maiko module for Typus, adds support for including images from maikoapp.com.

* http://www.maikoapp.com
* https://bitbucket.org/wollzelle/typus_maiko
* https://github.com/fesplugas/typus

## Installation

In your `Gemfile`:

    gem 'typus_maiko'

## Configuration

**In your model:**

    class Post < ActiveRecord::Base

      typus_maiko :gallery, account: 1, stack: 1
      typus_maiko :profile_photos, account: 1, stack: 2, preview: { width: 400, height: 200, crop: true } # use different preview sizes
      ...

### Translation

`typus_maiko` supports translatable captions through the [`typus_translate`](https://github.com/wollzelle/typus_translate) gem.

In your model:

    class Post < ActiveRecord::Base
      typus_maiko :gallery, account: 1, stack: 1, translatable: true

## Copyright

See LICENSE for details.