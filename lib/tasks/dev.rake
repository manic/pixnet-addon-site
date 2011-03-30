namespace :dev do

  desc "Rebuild system"
  task :rebuild => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate", "db:seed"]

  desc "Sample RSS, 提供一些範例 code"
  task :rss => :environment do
    rss_file = "#{::Rails.root}/doc/sample.rss"
    rss = SimpleRSS.parse File.open(rss_file).read
    item = rss.items.first
    puts item.link
  end

  task :test_domain => :environment do
    u = User.new
    u.login = 'manic'
    puts u.pixnet_link
  end

end
