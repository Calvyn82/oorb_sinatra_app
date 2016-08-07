namespace :elm do
  desc "Compile Elm"
  task :compile do
    Dir.chdir("elm") do
      sh "elm-make Oorb.elm --output ../public/javascripts/Oorb.js"
    end
  end
end
