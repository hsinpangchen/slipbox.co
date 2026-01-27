# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

# Load .env for local development if dotenv is available.
begin
  require "dotenv"
  Dotenv.load
rescue LoadError
  # dotenv is optional in some environments
end

# Google Analytics (GA4)
set :ga_measurement_id, ENV["GA_MEASUREMENT_ID"]

# i18n
activate :i18n,
         locales: [:en, :"zh-TW"],
         mount_at_root: false,
         path: "/:locale/"

# Legacy entrypoint for /slip (redirects to localized /{locale}/slip/)
proxy "/slip/index.html", "/slip-redirect.html", layout: false
# Legacy entrypoint for /slip/early-operators (redirects to localized path)
proxy "/slip/early-operators/index.html", "/early-operators-redirect.html", layout: false

# Enable directory indexes for clean URLs
activate :directory_indexes

# Commented out due to compatibility issues
# activate :autoprefixer do |prefix|
#   prefix.browsers = "last 2 versions"
# end

# Favicon maker (temporarily disabled due to compatibility issues)
# activate :favicon_maker, :icons => {
#   "source/images/slip/logo.png" => [
#     { icon: "favicon.ico", size: "64x64,32x32,24x24,16x16" },
#     { icon: "favicon-32x32.png" },
#     { icon: "favicon-16x16.png" },
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

helpers do
  def locale_prefix
    "/#{I18n.locale}"
  end

  def localized_path(path)
    return path if path.nil?
    return path if path.start_with?("http://", "https://", "mailto:", "tel:")

    path_part, hash = path.split("#", 2)
    return path if path_part.start_with?("/images", "/favicons", "/javascripts", "/stylesheets")

    normalized = url_for(path_part, locale: I18n.locale, relative: false)

    unless normalized.match?(%r{/(en|zh-TW)(/|$)})
      if path_part.end_with?("/") && path_part != "/"
        html_path = "#{path_part.chomp("/")}.html"
        normalized = url_for(html_path, locale: I18n.locale, relative: false)
        normalized = normalized.sub(/\.html$/, "/")
      end
    end
    hash ? "#{normalized}##{hash}" : normalized
  end

  def alternate_locale_path(locale)
    current_url = current_page.url || "/"
    path = current_url.sub(%r{^/(en|zh-TW)(/|$)}, "/")
    path = path.sub(%r{/index\.html$}, "/")
    path = "/" if path == ""

    localized = "/#{locale}#{path}".gsub(%r{//+}, "/")
    localized = localized.sub(%r{/index\.html$}, "/")

    if !localized.end_with?("/") && !localized.match?(/\.[a-z0-9]+$/i)
      localized = "#{localized}/"
    end

    localized
  end
end

after_configuration do
  I18n.default_locale = :en
  I18n.locale = :en
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

set :build_dir, 'build'

configure :build do


  activate :minify_css
  # activate :minify_javascript
  # activate :asset_hash
  activate :relative_assets
  set :relative_links, true





end


after_build do |builder|
  # Copy CNAME file for GitHub Pages
  if File.exist?('CNAME')
    FileUtils.cp('CNAME', config[:build_dir])
    puts "CNAME file copied to build directory"
  end
end
