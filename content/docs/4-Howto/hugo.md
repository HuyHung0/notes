# Hugo

Add a `_index.md` to a folder with the content `bookFlatSection: true` make the name of folder in bold letter.

```bash
hugo new site notes
cd notes
git init
git submodule add https://github.com/alex-shpak/hugo-book themes/hugo-book
```
Add theme to configuration file
```toml
baseURL = 'http://huyhung0.github.io/notes/'
languageCode = 'en-us'
title = 'Notes'
theme = "hugo-book"
```

Run:
```bash
hugo server --minify --theme hugo-book
```

