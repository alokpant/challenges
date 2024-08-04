#!/usr/bin/env ruby
# written in ruby 3.2.4
# Remember to make the script executable by running:
# chmod +x <filename>.rb

# Class to count words, lines and bytes
# Executable is at the end of the file
class WordCounter
  attr_reader :all_data 

  # buffer_size is used to split the file into multiple chunks
  # to prevent loading the whole file in Memory. This is called
  # Chunk-Based Processing
  BUFFER_SIZE = 8192 # 8kb
  
  def initialize
    @all_data = { lines: 0, words: 0, bytes: 0 }
  end

  # Read from single or multiple streams of filenames
  # Example: ./<file_name>.rb file_name1.txt file_name2.txt
  def read_from_files(filenames)
    filenames.each do |filename|
      begin
        # open the file in a read-only mode
        File.open(filename, "r") do |file|
          counts = count_from_io(file)
          print_result(filename, counts)
          update_total_counts(counts)
        end
      rescue Errno::ENOENT
        warn "Failed!. #{filename} does not exist"
      rescue Errno::EACCES
        warn "Failed!. Permission denied for #{filename}"
      end
    end

    # display all_data if there are more than single file
    return if filenames.count == 1

    print_result("All data", all_data)
  end

  # To facilitate also calculating counts only when string is passed.
  # Example:  echo "Hello World" | ./<file_name>.rb
  def read_from_stdin
    counts = count_from_io($stdin)
    print_result("Entered string -> #{$stdin}, result is:", counts)
  end

  private

  def count_from_io(io)
    totals_for_single_file = { lines: 0, words: 0, bytes: 0 }

    io.each(nil, BUFFER_SIZE) do |chunk|
      chunk.each_line do |line|
        totals_for_single_file[:lines] += 1
        totals_for_single_file[:words] += line.split.size
        totals_for_single_file[:bytes] += line.bytesize
      end
    end

    totals_for_single_file
  end

  def print_result(filename, count_hash)
    puts "\n\nFor file #{filename}, the output is:"
    puts "Total lines: #{count_hash[:lines]} \n"
    puts "Total words: #{count_hash[:words]} \n"
    puts "Total bytes: #{count_hash[:bytes]}"
  end

  def update_total_counts(counts)
    all_data.keys.each do |data_key|
      all_data[data_key] += counts[data_key]
    end
  end
end

# run the script
if ARGV.empty?
  WordCounter.new.read_from_stdin
else
  WordCounter.new.read_from_files(ARGV)
end

