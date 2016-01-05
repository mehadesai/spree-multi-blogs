require 'ffaiker'

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
        TRIES = 5
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
            
            published_at = Time.now - DAYS.sample.days
            title_words = (1..6).to_a.sample
            title = Faker::BaconIpsum.words(title_words).shuffle.join(' ').titleize
            permalink = [b.slug, published_at.strftime('%Y'), published_at.strftime('%m'), title.to_url].join('/')

            TRIES.times do |try|
              blog_entry_exists = Spree::BlogEntry.find_by(permalink: permalink)
              if blog_entry_exists.present?
                puts "\tTry #{try}...#{permalink} - #{blog_entry_exists.present?}"
                published_at = Time.now - DAYS.sample.days
                permalink = [b.slug, published_at.strftime('%Y'), published_at.strftime('%m'), title.to_url].join('/')
                title_words = (1..6).to_a.sample
                title = Faker::BaconIpsum.words(title_words).shuffle.join(' ').titleize
              else
                next
              end
            end

            be.title = title
            be.published_at = published_at
            be.summary = Faker::BaconIpsum.sentences
            be.author_id = users.sample.id

            body_arr = ['a', 'body', 'fancy_string', 'p', 'ul_long']
            be.body = body_arr.sample(3).map { |b| Faker::HTMLIpsum.send(b.to_sym) }.join('')

            be.save!
          end
        end
        puts "Seeding complete!"
      end
    end
  end
end
