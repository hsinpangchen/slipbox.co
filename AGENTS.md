# Repository Guidelines

## Project Structure & Module Organization
- `source/` holds the Middleman site source. `source/slip/` contains partials such as `_hero.erb` and page templates like `index.html.erb`, `privacy.html.erb`, and `support.html.erb`.
- `source/layouts/` defines shared layouts (`home.erb`, `slip.erb`, `privacy.erb`).
- `source/stylesheets/`, `source/javascripts/`, `source/images/`, and `source/favicons/` contain assets.
- `build/` is generated output. Do not edit it manually; it is recreated on build/deploy.
- `config.rb` configures Middleman; `Rakefile` defines build/deploy tasks; `spec/` stores screenshot assets.

## Build, Test, and Development Commands
- `bundle install` installs Ruby gem dependencies.
- `bundle exec middleman server` runs the local dev server with live reload.
- `bundle exec middleman build` builds the static site into `build/`.
- `rake build` builds the site and copies `CNAME` into `build/`.
- `rake deploy` builds and force-pushes `build/` to the production GitHub Pages remote.
- `rake clean` removes the `build/` directory.

## Coding Style & Naming Conventions
- Indentation is 4 spaces in ERB/HTML, SCSS, and JS (match existing files).
- SCSS is centralized in `source/stylesheets/site.css.scss`; keep sections grouped by feature.
- JS lives in `source/javascripts/site.js` and uses vanilla DOM APIs.
- Partials are prefixed with `_` (e.g., `_features.erb`) and included from layouts/pages.
- Assets should be added under `source/images/` and referenced with `/images/...` paths.

## Testing Guidelines
- No automated test framework is configured. Validate changes by running `bundle exec middleman build` and reviewing key pages in a browser.

## Commit & Pull Request Guidelines
- Recent commit messages are short, sentence-case summaries (e.g., “Remove VitePress files and configuration”), with no strict prefixing. Keep messages concise and descriptive.
- PRs should include a brief summary and screenshots for visual changes (homepage, privacy/support pages).
- Avoid committing generated `build/` output unless intentionally deploying via `rake deploy`.

## Development Environment
- Ruby 3.3.8 is the expected local version (see `.ruby-version`). If you use `rbenv`, run `rbenv install 3.3.8` and `rbenv local 3.3.8` before `bundle install`.

## Deployment Notes
- Deployment is handled by `rake deploy`, which builds and pushes the `build/` directory to the production GitHub Pages remote and copies `CNAME`.
