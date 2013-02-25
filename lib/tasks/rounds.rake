desc "Creates a new round if one hasn't been created yet"
task :round_create => :environment do
  Pair.auto_create
end

