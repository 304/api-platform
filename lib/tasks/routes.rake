desc "API Routes"
task :route => :environment do
  puts
  puts ['Method', 'Path', 'Description'].map { |name| name.ljust(11) }.join
  puts '-' * 40

  API.routes.each do |api|
    method = api.route_method.ljust(10)
    path = api.route_path.ljust(10)
    description = api.route_description

    puts "#{method} #{path} #{description}"
  end
end