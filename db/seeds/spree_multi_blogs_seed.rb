require 'ffaker'

namespace :db do
  namespace :seed do
    puts "----------here-----------"
    Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].each do |filename|
      task_name = File.basename(filename, '.rb').to_sym
      puts "----#{task_name}----"
      task task_name => :environment do
        load(filename) if File.exist?(filename)

        puts "Start seeding..."
        BLOGS = 5
        BLOG_POSTS = (50..100).to_a
        DAYS = (1..365).to_a
        users = Spree::User.includes(:spree_roles).where(spree_roles: { name: 'admin' }).limit(10)
        BLOGS.times do |blog_index|
          puts "\tCreating Blog #{blog_index}..."
          b = Spree::Blog.new
          b.name = Faker::Food.herb_or_spice
          b.save!

          blog_posts = BLOG_POSTS.sample
          blog_posts.times do |blog_entry_index|
            puts "\tPost #{blog_entry_index}"
            be = Spree::BlogEntry.new
            be.blog_id = b.id
            be.title = Faker::Movie.title
            be.published_at = Time.now - DAYS.sample.days
            be.summary = Faker::BaconIpsum.sentences
            be.author_id = users.sample.id
            be.body = Faker::HTMLIpsum
            be.save!
          end
        end
        puts "Seeding complete!"
      end
    end
  end
end
