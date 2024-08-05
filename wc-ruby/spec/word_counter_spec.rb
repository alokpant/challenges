require 'rspec'
require './spec/spec_helper'
require_relative '../calculate_wc' # load the file

RSpec.describe WordCounter do
  let(:counter) { described_class.new }

  describe "#read_from_stdin" do
    it "when it is a single line, counts lines, words and bytes correctly" do
      original_stdin = $stdin
      $stdin = StringIO.new("Hello stdin\n")
      
      counts = counter.send(:count_from_io, $stdin)
      
      expect(counts[:lines]).to eq(1)
      expect(counts[:words]).to eq(2)
      expect(counts[:bytes]).to eq("Hello stdin\n".bytesize)
      
      $stdin = original_stdin
    end
  end

  describe "#read_from_files" do
    let(:file_content) {
      [
        "Hello world\n",
        "Another test\n"
      ]
    }
    
    before do
      File.write('test_file1.txt', file_content[0])
      File.write('test_file2.txt', file_content[1])
    end

    after do
      File.delete('test_file1.txt')
      File.delete('test_file2.txt')
    end

    it "when it loads a single file, counts lines, words and bytes correctly" do
      counts = counter.read_from_files(['test_file1.txt'])
      
      expect(counts[:lines]).to eq(1)
      expect(counts[:words]).to eq(2)
      expect(counts[:bytes]).to eq(12)
    end
    
    it "when it loads multiple files, counts lines, words and bytes correctly" do
      counts = counter.read_from_files(['test_file1.txt', 'test_file2.txt'])

      expect(counts[:lines]).to eq(2)
      expect(counts[:words]).to eq(4)
      expect(counts[:bytes]).to eq(25)
    end
  end
end
