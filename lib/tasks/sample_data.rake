namespace :sample_data do
  task generate: :environment do
    require "#{Rails.root}/lib/sample_data"
    SampleData.generate
  end
end
