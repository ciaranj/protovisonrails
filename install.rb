require 'FileUtils'

dir = Dir.getwd

# Copy required javascripts to public/javascripts
begin
  FileUtils.copy(Dir[File.dirname(__FILE__) + '/javascripts/protovis.js'], File.dirname(__FILE__) + '/../../../public/javascripts/')
rescue
  puts "Could not copy protovis.js.  Please manually copy them to your public/javascripts directory."
end