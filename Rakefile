require 'rake/testtask'

task :default => :test

Rake::TestTask.new :test do |t|
  t.libs << 'test'
  t.pattern = 'test/**/test_*.rb'
end

namespace :elm do
  desc "Compile Elm"
  task :compile do
    Dir.chdir("elm") do
      sh "elm-make Oorb.elm --output ../public/javascripts/Oorb.js"
    end
  end
end
