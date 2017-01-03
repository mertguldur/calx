task :console do
  require 'irb'
  require 'irb/completion'
  require 'calx_client' # You know what to do.

  def reload!
    # Change 'calx_client' here too:
    files = $LOADED_FEATURES.select { |feat| feat =~ /\/calx_client\// }
    files.each { |file| load file }
  end

  ARGV.clear
  IRB.start
end
