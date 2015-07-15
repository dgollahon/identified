require 'nokogiri'
require 'open-uri'
require 'pry'

doc = Nokogiri::HTML(open('http://www.ssa.gov/employer/ssnvhighgroup.htm'))

doc.css('a').each do |link|
  if link['href'] =~ /\b.+.txt/
    sleep(1)
    begin
      link_name = link.children.first.to_s
      file_name = link_name.strip.downcase.sub(/\s/, '_') + '_raw.txt'
      puts 'Writing: ' + file_name
      File.open("data/ssn/high_groups/#{file_name}", 'w') do |file|
        downloaded_file = open('http://www.ssa.gov/employer/' + link['href'])
        file.write(downloaded_file.read())
      end
    rescue => ex
      puts 'ERROR! Could not download high group data: ' + ex.to_s
    end
  end
end
