require 'fileutils'

desc "Build the site with middleman"
task :build do
  puts "Building site..."
  system("bundle exec middleman build")
  
  # Copy CNAME file to build directory
  if File.exist?('CNAME')
    FileUtils.cp('CNAME', 'build/CNAME')
    puts "CNAME file copied to build directory"
  else
    puts "Warning: CNAME file not found in root directory"
  end
end

desc "Deploy to git@github.com:hsinpangchen/slipbox.co.git"
task :deploy => :build do
  puts "Deploying to git@github.com:hsinpangchen/slipbox.co.git..."
  
  # Check if build directory exists
  unless Dir.exist?('build')
    puts "Build directory not found. Run 'rake build' first."
    exit 1
  end
  
  # Change to build directory
  Dir.chdir('build') do
    # Initialize git if needed
    unless Dir.exist?('.git')
      system('git init')
      system('git remote add production git@github.com:hsinpangchen/slipbox.co.git')
    end
    
    # Configure git user
    system('git config user.name "Deploy Bot"')
    system('git config user.email "deploy@slipbox.co"')
    
    # Add all files
    system('git add -A')
    
    # Commit with timestamp
    commit_message = "Deploy site - #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}"
    system("git commit -m '#{commit_message}'")
    
    # Push to main branch (force push to overwrite)
    system('git push -f production main')
    
    puts "Deployment complete!"
  end
end

desc "Clean build directory"
task :clean do
  if Dir.exist?('build')
    FileUtils.rm_rf('build')
    puts "Build directory cleaned."
  end
end

task :default => :build