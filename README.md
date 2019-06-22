# 200wad backup script

This script creates a local backup of txt files, one for each of your entries on [200wordsaday](https://200wordsaday.com/).

1. Create a file called `api_key.rb` with the following:
    ```ruby
    API_KEY = '[your api key from 200wad]'
    ```
1. Update `root_dir` to be the local directory you want your backup to live
1. Install [httparty](https://github.com/jnunemaker/httparty): `gem install httparty`
1. Run `ruby 200wad.rb`!

The script safely removes old backups. Edit `next if item == '.' or item == '..' or item == '.DS_Store'` appropriately, as it assumes a Mac filesystem.

It also strips markup, converting paragraphs and blockquotes. For example:

```html
<p>Lorem <a href="http://example.com">ipsum dolor</a> sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>

<blockquote>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</blockquote>

<p>Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur.</p>
```

will become:

```text
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

    Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur.
```

## Todo

- Convert links into footnotes
