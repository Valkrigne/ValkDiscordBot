require 'optparse'
def option_parse
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: boot.rb [options]"

    opts.on("-i", "--install", "install dependencies") do |v|
      options[:install] = v
    end

    opts.on('-c', '--check', 'check dependencies') do |v|
      options[:check] = v
    end

    opts.on("-h", "--help", "Prints help") do
      puts opts
      exit
    end
  end.parse!
  return options
end
