require 'optparse'
require 'uri'
require 'net/http'
require 'json'

DOMAIN_ID_KEY = :domain_id
FOLDER_KEY = :folder
LIST_DOMAINS_KEY = :list_domains
BASE_URL = 'http://127.0.0.1:3000'

def get_args
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
    uri = URI(BASE_URL+'/domains')
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

def download_images(domain_id, folder)
    puts "Domain ID: #{domain_id}"
    puts "Root folder: #{folder}"
end

def handle_args
    args = get_args()

    domain_id = args[DOMAIN_ID_KEY]
    folder = args[FOLDER_KEY]
    is_list_domains = args[LIST_DOMAINS_KEY]

    if (is_list_domains)
        list_domains()
    elsif (not domain_id.nil?)
        download_images(domain_id, folder)
    else
        puts "Please, use valid arguments"
    end
end

handle_args()