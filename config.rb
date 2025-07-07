# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

# Commented out due to compatibility issues
# activate :autoprefixer do |prefix|
#   prefix.browsers = "last 2 versions"
# end

# Favicon maker (commented out - add favicon.png to source/images/ to enable)
# activate :favicon_maker, :icons => {
#   "source/images/favicon.png" => [
#     { icon: "apple-touch-icon-152x152-precomposed.png" },
#     { icon: "favicon-32x32.png" },
#     { icon: "favicon-16x16.png" },
#     { icon: "favicon.ico", size: "64x64,32x32,24x24,16x16" },
#   ]
# }

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  activate :minify_css
  # activate :minify_javascript
  # activate :asset_hash
  activate :relative_assets
  set :relative_links, true
end

# Deploy configuration (commented out to avoid dependency issues)
# activate :deploy do |deploy|
#   deploy.deploy_method = :git
#   deploy.branch = 'gh-pages'
#   deploy.build_before = true
# end
