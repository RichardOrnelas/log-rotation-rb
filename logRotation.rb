#!/usr/bin/ruby
# Log List file path
log_list = "/Users/rich/GitHub/log-rotation-rb/log_list.txt"
# File Size Limit (FSL)
fsl = 500000

#Add contents of each line in log_list as an element in the array logsArray
f = File.open("#{log_list}" , "r")
logsArray = []
f.each_line { |line|
logsArray.push line.chomp
}

#Go through log file and parse
logsArray.each { |log|
f = File.open("#{log}")
#Extract name segments as variables
bn = File.basename("#{log}", ".*")
dn = File.dirname("#{log}")
ext = File.extname("#{log}")
ts = Time.new.strftime("%Y-%m-%d-%H%M%S")
log = "#{dn}/#{bn}_#{ts}#{ext}"

#If a log is too big...
if f.size > fsl
	#Rename it
	File.rename("#{dn}/#{bn}#{ext}", "#{log}")
	#Create a new one
	n = File.new("#{dn}/#{bn}#{ext}", "w")
	n.puts("start of a new log")
	n.close
end
}

# Remove oldest log file if over 5 in directory
# Add file path array elements to |path|
logsArray.each { |path|
f = File.open("#{path}")
dir = File.dirname("#{path}")

# Count the number of files in the directory
count = Dir[File.join(dir, '*')].count { |file| File.file?(file) }
if count > 5
	files = Dir[File.join(dir, '*.log')].sort_by { |filename| File.mtime(filename) }.first
	File.delete("#{files}")
	puts "I just deleted #{files}"
end
}
