# log-rotation-rb
Log rotator in Ruby
Your goal is to build a simple log rotator using Ruby adhering to the following
requirements.

## Requirements

Read a file containing paths to log files on each line as the source for log
files to rotate. The log file should be rotated when the file size reaches 500kb
or greater. It should retain 5 rotations of each log file and clean up rotations
older than that.

## Example Source Log File

> /some/path/to/a.log
> /some/other/path/to/b.log
> /path/to/c.log
