namespace :dev do

  desc "Setup the development environment"
  task setup: :environment do
    p "Recording Domains"
    
    5.times do |i|
      Domain.create!(
        description: Faker::Creature::Dog.breed
      )
    end

    p "Domains recorded"

    p "Recording Image Classes"

    Domain.all.each { |domain_instance|
      3.times do |i|  
        ImageClass.create!(
          name: Faker::Creature::Dog.age,
          domain: domain_instance
        )
      end
    }

    p "Image classes recorded"

    p "Recording Images"

    ImageClass.all.each { |image_class_instance|
      3.times do |i|  
        Image.create!(
          url: Faker::Internet.url(scheme: 'https'),
          image_class: image_class_instance
        )
      end
    }

    p "Image classes recorded"
  end
end
