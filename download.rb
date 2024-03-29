require 'optparse'
require 'uri'
require 'net/http'
require 'json'
require 'fileutils'
require "open-uri"

DOWNLOADS_FOLDER = './downloads/domains'

DOMAIN_ID_KEY = :domain_id
FOLDER_KEY = :folder
LIST_DOMAINS_KEY = :list_domains

BASE_URL = 'http://127.0.0.1:3000'
DOMAINS_END_POINT = '/domains/'
IMAGE_CLASSES_END_POINT = '/image_classes/'
IMAGES_END_POINT = '/images/'

def get_args()
    hash_options = {}
    OptionParser.new do |opts|
        opts.banner = "Usage: download_images [options]"
        opts.on('-d [ARG]', '--domain [ARG]', "Specify the domain id to download its images") do |v|
            hash_options[:domain_id] = v
        end
        opts.on('-f [ARG]', '--folder [ARG]', "Root folder to save the downloaded images") do |v|
            hash_options[:folder] = v
        end
        opts.on('-l', '--list_domains', "To list every possible domain with its id") do
            hash_options[:list_domains] = true
        end
        opts.on('-h', '--help', 'To get the available arguments') do 
            puts opts
            exit
        end
    end.parse!

    return hash_options
end

def list_domains()
    uri = URI(BASE_URL+DOMAINS_END_POINT)
    response = Net::HTTP.get_response(uri)

    if (response.is_a?(Net::HTTPSuccess))
        domain_list = JSON.parse(response.body)

        domain_list.each do |domain_object|
            domain_id = String(domain_object['id'])
            domain_description = domain_object['description']

            puts domain_id + " - " + domain_description
        end
    else
        puts "Resource not found - try again"
    end
end

def get_domain(domain_id)
    uri = URI(BASE_URL+DOMAINS_END_POINT+domain_id)
    response = Net::HTTP.get_response(uri)

    domain_object = nil
    if (response.is_a?(Net::HTTPSuccess))
        domain_object = JSON.parse(response.body)
    else
        puts "Resource not found - try again"
    end

    return domain_object
end

def create_dir_if_not_exists(dir_name)
    unless File.directory?(dir_name)
        FileUtils.mkdir_p(dir_name)
    end
end

def get_image_classes_end_point_uri(domain_id)
    return URI(
                BASE_URL+
                DOMAINS_END_POINT+
                String(domain_id)+
                IMAGE_CLASSES_END_POINT
            )
end

def get_image_classes_by_domain(domain_id)
    uri = get_image_classes_end_point_uri(domain_id)
    response = Net::HTTP.get_response(uri)

    domain_list = []

    if (response.is_a?(Net::HTTPSuccess))
        domain_list = JSON.parse(response.body)
    end
    
    return domain_list
end

def get_images_by_class_end_point_uri(image_class_id)
    request_url = URI(
        BASE_URL+
        IMAGE_CLASSES_END_POINT+
        String(image_class_id)+
        IMAGES_END_POINT
    )

    return request_url
end

def get_images_by_class(image_class_id)
    uri = get_images_by_class_end_point_uri(image_class_id)
    response = Net::HTTP.get_response(uri)

    images_list = []

    if (response.is_a?(Net::HTTPSuccess))
        images_list = JSON.parse(response.body)
    end
    
    return images_list
end

def download_image_files_by_class(image_class, image_class_folder_path)
    puts "Start download for class: #{image_class['name']}"
    
    image_class_id = String(image_class['id'])
    images = get_images_by_class(image_class_id)

    images.each do |image_object|
        image_id = String(image_object['id'])
        image_url = image_object['url']

        uri = URI(image_url)
        save_path = image_class_folder_path + '/' + image_id + '.jpg'

        uri.open do |image|
            File.open(save_path, "wb") do |file|
              file.write(image.read)
            end
        end
    end

    puts "Finished download for class: #{image_class['name']}"
    puts "-------"
end

def download_images(domain_object, root_folder)
    domain_id = domain_object['id']
    domain_description = domain_object['description']
    
    image_classes = get_image_classes_by_domain(domain_id)

    image_classes.each do |image_class_object|
        class_id = String(image_class_object['id'])
        class_name = image_class_object['name']

        image_class_folder_path = root_folder + '/' + class_id + '-' + class_name
        create_dir_if_not_exists(image_class_folder_path)

        download_image_files_by_class(image_class_object, image_class_folder_path)
    end
end

def build_root_folder_path(folder_name, domain_object)
    base_folder = folder_name ? DOWNLOADS_FOLDER + '/' + folder_name : DOWNLOADS_FOLDER

    domain_id = domain_object['id']
    domain_description = domain_object['description']
    
    return base_folder + '/' + String(domain_id) + '-' + domain_description
end

def download_images_gui(domain_id, folder_name)
    puts "Input data:"
    puts "|--- Domain ID: #{domain_id}"
    puts "|--- Domain Folder Name: #{folder_name}"

    puts "Procced with the request? (y/N)"
    input = gets.chomp
    
    if (input == "y")
        domain_object = get_domain(domain_id)

        if (not domain_object.nil?)
            puts "|--- Domain Name: #{domain_object['description']}"
        
            puts "Procced with the request? (y/N)"
            input = gets.chomp

            if (input == "y")
                root_folder = build_root_folder_path(folder_name, domain_object)
                download_images(domain_object, root_folder)
            end            
        end
    end

    puts "End of execution..."
end

def handle_args()
    args = get_args()

    domain_id = args[DOMAIN_ID_KEY]
    folder = args[FOLDER_KEY]
    is_list_domains = args[LIST_DOMAINS_KEY]

    if (is_list_domains)
        list_domains()
    elsif (not domain_id.nil?)
        download_images_gui(domain_id, folder)
    else
        puts "Please, use valid arguments"
    end
end

handle_args()