#!/usr/bin/ruby
# Files Paths
# logs/a.log , logs/some/b.log, logs/some/more/c.log

# File Size Limit (FSL)
fsl = 20

# Log List file path
log_list = "/Users/rich/GitHub/log-rotation-rb/log_list.txt"

#Add contents of each line in log_list as an element in the array logsArray
f = File.open("#{log_list}" , "r")
logsArray = []
f.each_line { |line| 
logsArray.push line.chomp
}

#Go through log file and check size
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
	puts "#{f.size}"
	puts "#{bn}"
	puts "#{dn}"
	puts "#{ext}"
	puts "#{log}"
	#Rename it
	File.rename("#{dn}/#{bn}#{ext}", "#{log}")
	#Create a new one
	n = File.new("#{dn}/#{bn}#{ext}", "w")
	n.puts("start of a new log")
	n.close
else
	puts "Keep logging"
end
}

#Remove oldest log file if over 5 in directory

# Add file path array elements to |path|
logsArray.each { |path|
f = File.open("#{path}")
dir = File.dirname("#{path}")
puts "#{dir}"
# Count the number of files in the directory
count = Dir[File.join(dir, '*')].count { |file| File.file?(file) }
puts "#{count}"

if count > 5
	puts "Some Files need to be deleted"
	# Get Files in Directory, sorted by age
	# Remove the oldest
else
	puts "everything is chill"
end
}

