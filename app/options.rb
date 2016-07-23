require 'optparse'
def option_parse
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: boot.rb [options]"

  end.parse!
  return options
end
