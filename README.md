Clips
=====

An Instapaper-ish web application that allows you to collect URLs to check later. Collect URLs using the included bookmarlet, which saves the URL of the current page.


# Running the application
Clips is written in [Camping](http://camping.io). Start by `bundle install`-ing gems. Then start the server.

    $ bundle install
    $ rackup

Use [Rerun](https://github.com/rerun/rerun) to auto-restart the server when the filesystem changes:

    $ rerun -- rackup

A great shell you can use is [Racksh](https://github.com/sickill/racksh). Start it and you can inspect the `Clip` model.

    $ racksh
    $ Clip::Models::Clip.all


# License
Clips is licensed under the MIT License. See the included LICENSE file.
