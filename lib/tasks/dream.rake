desc "Dream to twitter"
task :dream, [:keyword] => [:environment] do |t, args|
  Dreamer.dream(args[:keyword] || 'dream')
end
