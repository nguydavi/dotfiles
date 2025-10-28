# Install
```
git clone git@github.com:nguydavi/dotfiles.git
cd dotfiles
./install/bootstrap.sh
```

# Validation
```
# Run the installation script on a fresh Linux image
./validation/check.sh
# Run the installation script on a fresh Linux image and drop to a shell for debugging
./validation/check.sh -d
```

```
# Rerunning on an already setup machine should also pass (idempotent scripts)
./install/bootstrap.sh
```

# Manual Steps

## Firefox
* Install https://github.com/mbnuqw/sidebery
* Go to `about:config` and set `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`
* Find the root profile folder `about:profiles`
* Create a `chrome` there and make a symlink for `userChrome.css` from this repo
    ```sh
    ln -s ~/dotfiles/userChrome.css ~/Library/Application\ Support/Firefox/Profiles/abcdefg123.default-release/chrome/userChrome.css
    ```

More info at
* https://github.com/mbnuqw/sidebery/wiki/Firefox-Styles-Snippets-(via-userChrome.css)
* https://github.com/MrOtherGuy/firefox-csshacks?tab=readme-ov-file#setup

### Sidebery
* For important work, make sure to enable snapshot backups

## Youtube Music
* Open Youtube Music in Safari
* Press the share button  -> `Add to Dock`
