desc "Dream to twitter"
task :dream, [:keyword] => [:environment] do |t, args|
  Dreamer.new.dream(args[:keyword] || 'dream')
end
