## Image Labeling System - API
1. App usage guide - [go to the app repository](https://github.com/MaximoDouglas/image-labeling-app)
2. [Simplified architecture](#simplified-architecture)
3. [Setup the API](#setup-the-api)
4. [Running the API](#running-the-api)
5. Setup and run app - [go to the app repository](https://github.com/MaximoDouglas/image-labeling-app)

This is the API side of a project created to facilitate the __data acquisition__ and the __data labelling__ steps for supervised computer vision tasks. 

You just need to create an image __Domain__ (e.g. **animals**) and its __Classes__ (e.g. **Dog**, **Cat** and **Duck**) to start the labeling.

## Simplified architecture
![Image Labeling system simple diagram](image-labeling.png)

## Setup the API
1. [Setup ruby - version 2.7.0](https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/ownserver/nginx/oss/install_language_runtime.html)
2. Install rails 5.2.4 with `gem install rails -v 5.2.4`
3. Run `bundle install` to install the project dependencies
4. Run `rails db:create` to create the database and `rails db:migrate` to run the database migrations 

## Running the API
1. Run the project with `rails server -b 0.0.0.0` to let the API visible in your intranet
2. If everything goes well, your API is running on `http://<your IP Address>:3000`
3. Now, you just need to get your API address to setup the App side, following the instructions on the [App Repository](https://github.com/MaximoDouglas/image-labeling-app).
  
