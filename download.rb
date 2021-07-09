require 'optparse'

def get_args
    hash_options = {}
    OptionParser.new do |opts|
        opts.banner = "Usage: download_images [options]"
        opts.on('-d [ARG]', '--domain [ARG]', "Specify the domain id to download its images") do |v|
            hash_options[:domain_id] = v
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

args = get_args()