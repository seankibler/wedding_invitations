namespace :server do
  task :start do
    system 'rails server -p 8000'
  end
end
