#!/usr/bin/env ruby

print "Watching for changes in .erb files...\n"

# Initial scan
watched_files = Dir.glob("*.erb")
last_mtimes = {}

watched_files.each do |file|
  last_mtimes[file] = File.mtime(file)
end

loop do
  # Rescan for new files (optional, but good practice)
  current_files = Dir.glob("*.erb")
  
  changes_detected = false
  
  current_files.each do |file|
    begin
      current_mtime = File.mtime(file)
      
      if !last_mtimes.key?(file)
        # New file detected
        puts "New file detected: #{file}"
        last_mtimes[file] = current_mtime
        changes_detected = true
      elsif current_mtime > last_mtimes[file]
        # File modified
        puts "Change detected in: #{file}"
        last_mtimes[file] = current_mtime
        changes_detected = true
      end
    rescue Errno::ENOENT
      # File might have been deleted during the loop
      last_mtimes.delete(file)
    end
  end

  if changes_detected
    puts "Regenerating site..."
    system("ruby gen.rb")
    puts "Done."
    print "Watching for changes in .erb files...\n"
  end

  sleep 1
end
