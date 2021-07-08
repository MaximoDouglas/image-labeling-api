require 'optparse'

def get_args
    hash_options = {}
    OptionParser.new do |opts|
        opts.banner = "Usage: download_images [options]"
        opts.on('-d [ARG]', '--domain [ARG]', "Specify the domain id to download its images") do |v|
            hash_options[:argument_a] = v
        end
        opts.on('-l [ARG]', '--list_domain [ARG]', "To list every possible domain with its id") do |v|
            hash_options[:argument_b] = v
        end
        opts.on('-h', '--help', 'To get the available arguments') do 
            puts opts
            exit
        end
    end.parse!

    return hash_options
end

args = get_args()
puts args