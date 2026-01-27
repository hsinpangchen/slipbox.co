# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

# Load .env for local development if dotenv is available.
begin
  require "dotenv"
  Dotenv.load
rescue LoadError
  # dotenv is optional in some environments
end

require "i18n"

SUPPORTED_LOCALES = [:en, :"zh-TW"].freeze

I18n.load_path += Dir[File.join(root, "locales", "*.yml")]
I18n.available_locales = SUPPORTED_LOCALES
I18n.default_locale = :en
I18n.enforce_available_locales = false

# Google Analytics (GA4)
set :ga_measurement_id, ENV["GA_MEASUREMENT_ID"]

# Legacy entrypoint for /slip (redirects to localized /{locale}/slip/)
proxy "/slip/index.html", "/slip-redirect.html", layout: false

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
  def t(*args)
    ::I18n.t(*args)
  end

  def locale_prefix
    "/#{I18n.locale}"
  end

  def localized_path(path)
    return path if path.nil?
    return path if path.start_with?("http://", "https://", "mailto:", "tel:")

    path_part, hash = path.split("#", 2)
    return path if path_part.start_with?("/images", "/favicons", "/javascripts", "/stylesheets")

    normalized = if path_part == "" || path_part == "/"
                   "#{locale_prefix}/"
                 elsif path_part.start_with?("/")
                   "#{locale_prefix}#{path_part}"
                 else
                   "#{locale_prefix}/#{path_part}"
                 end

    hash ? "#{normalized}##{hash}" : normalized
  end

  def alternate_locale_path(locale)
    current_url = current_page.url || "/"
    path = current_url.sub(%r{^/(en|zh-TW)(/|$)}, "/")
    path = path.sub(%r{/index\.html$}, "/")
    path = "/" if path == ""

    localized = "/#{locale}#{path}".gsub(%r{//+}, "/")

    if localized.end_with?("/index.html")
      localized = localized.sub(%r{/index\.html$}, "/")
    end

    if !localized.end_with?("/") && !localized.match?(/\.[a-z0-9]+$/i)
      localized = "#{localized}/"
    end

    localized
  end
end

app.before_render do |body, _path, locs, _template_class|
  I18n.locale = (locs && locs[:locale]) || I18n.default_locale
  body
end

ready do
  sitemap.resources.each do |resource|
    next if resource.is_a?(Middleman::Sitemap::ProxyResource)
    next unless resource.ext == ".html"
    next if resource.path == "index.html"
    next if resource.path == "slip-redirect.html"

    SUPPORTED_LOCALES.each do |locale|
      localized_path = case resource.path
                       when "home.html"
                         File.join(locale.to_s, "index.html")
                       when "slip/home.html"
                         File.join(locale.to_s, "slip/index.html")
                       else
                         File.join(locale.to_s, resource.path)
                       end
      proxy localized_path, resource.path, locals: { locale: locale }, ignore: true
    end
  end
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
