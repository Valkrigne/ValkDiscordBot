module GemInstall
  def self.install_gem_library(output)
    gemfile = File.new('./config/gemfile')

    while (line = gemfile.gets)
      g = line.strip.split(',')
      gem_name = g[0]
      *gem_ver_reqs = g[1] unless g[1].nil?

      gdep = Gem::Dependency.new(gem_name, *gem_ver_reqs)
      # find latest that satisifies
      found_gspec = gdep.matching_specs.max_by(&:version)

      if found_gspec
        puts "#{found_gspec.name}-#{found_gspec.version}"
      else
        puts "'#{gdep}' not found"
        # reqs_string will be in the format: "> 1.0, < 1.2"
        reqs_string = gdep.requirements_list.join(', ')
        # multi-arg is safer, to avoid injection attacks
        system('gem', 'install', gem_name, '-v', reqs_string)
      end
    end
    gemfile.close
  end
end
