# 1. Word Counter
Based on the challenge found on [codingChallenge](https://codingchallenges.fyi/challenges/challenge-wc/)

## Description

Build Your Own wc Tool

This challenge is to build your own version of the Unix command line tool wc!

The Unix command line tools are a great metaphor for good software engineering and they follow the Unix Philosophies of:

- Writing simple parts connected by clean interfaces - each tool does just one thing and provides a simple CLI that handles text input from either files or file streams.
- Design programs to be connected to other programs - each tool can be easily connected to other tools to create incredibly powerful compositions.

## Process to execute

1. Make the script executable
```
chmod +x wc_ruby.rb
```
2. Run the script

2.1. Run against a static text
```
echo "Hello World" | ./wc_ruby.rb
```

2.2. Run against a file
```
./wc_ruby.rb file_to_count.txt
```

3. Run against multiple files
```
./wc_ruby.rb file1.txt file2.txt file3.txt
```
