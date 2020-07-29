namespace :dev do

  desc "Setup the development environment"
  task setup: :environment do
    p "Recording Domains"
    5.times do |i|
      Domain.create!(
        description: Faker::Creature::Animal.name
      )
    end

    p "Domains recorded"
  end


end
