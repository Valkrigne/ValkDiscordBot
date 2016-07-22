module GemCheck
  def self.check_gem_library(output)
    gemfile = File.new('./config/gemfile')
    dependecy_met = true;
    while (line = gemfile.gets)
      g = line.strip.split(',')
      gem_name = g[0]
      *gem_ver_reqs = g[1] unless g[1].nil?

      gdep = Gem::Dependency.new(gem_name, *gem_ver_reqs)
      # find latest that satisifies
      found_gspec = gdep.matching_specs.max_by(&:version)

      if found_gspec
        puts "#{found_gspec.name}-#{found_gspec.version}" if output
      else
        puts "'#{gdep}' not found"  if output
        dependecy_met = false
      end
    end
    gemfile.close

    exit unless (dependecy_met && !output)
  end
end
