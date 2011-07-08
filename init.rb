require 'net/http'
require 'rubygems'
require 'xmlsimple'

youtube_top_rated_videos_feed_uri = 'http://gdata.youtube.com/feeds/api/standardfeeds/IT/top_rated'
uri= URI.parse(youtube_top_rated_videos_feed_uri)

File.open("file1.xml", "w+") do |f1|
  Net::HTTP.start(uri.host, uri.port) do |http|
    f1.puts(http.get(uri.path))
  end
end

feed = XmlSimple.xml_in("file1.xml", {'KeyAttr' => 'name'})
File.open("file2.txt", "w") do |f2|
  (0..24).each do |i|
    f2.write(feed['entry'][i]['title'][0]['content'])
    f2.write("\n")
    f2.write(feed['entry'][i]['link'][0]['href'])
    f2.write("\n")
    f2.write("\n")
  end 
end
