# uses the 200wordsaday.com API to export your posts as text files
# to install httparty:
# gem install httparty
require 'httparty'
require 'json'
require 'date'
require 'fileutils'
load 'api_key.rb'

# make new directory for this export
root_dir = "/Users/danielmiller/Dropbox (Personal)/writing/200wad/"
current_folder = Time.now.to_s.split(" ")[0]
new_dir = root_dir + current_folder + "/"
FileUtils.mkdir_p new_dir unless Dir.exists?(new_dir)

begin
  url = 'https://200wordsaday.com/api/texts?api_key=' + API_KEY
  response = HTTParty.get(url)
  entries = response.parsed_response
  puts entries.length.to_s + " entries read from API"
  entries_with_content = 0
  entries.each do |entry|
    entrydate = Date.strptime(entry["datetime"]["date"], '%Y-%m-%d').to_s
    filename = new_dir + entrydate + "-" + entry["title"].gsub(/[^\w\s]/, '').gsub(" ", "-") + '.txt'
    if entry["content"]
      entries_with_content += 1
      content = entry["content"].
        gsub("</p>", "\n\n").
        gsub("</blockquote>", "\n\n").
        gsub("<blockquote>", "    ").
        gsub(/<\/?[^>]*>/, "").
        gsub(/&nbsp;/, " ").strip
    end
    File.write filename, content
  end
  puts "wrote " + entries_with_content.to_s + " files to " + new_dir

  # clean up old dirs
  Dir.foreach(root_dir) { |item|
    folder_full_path = root_dir + item
    next if item == '.' or item == '..' or item == '.DS_Store'
    # don't delete the current backup
    next if item == current_folder
    # don't delete backups that have more files than were just pulled
    next if Dir.entries(folder_full_path).length > entries_with_content + 3
    puts "deleting " + item
    FileUtils.rm_rf folder_full_path
  }
rescue StandardError => msg  
  puts msg  
end
