Spree Multiple Blogs
==================

A blogging solution that supports multiple blogs for use with the [Spree](http://github.com/spree/spree/) E-Commerce platform.

The blog is found under /admin/blogs on the website admin. Blog entries can be accessed on the front end using the permalink for the blog post, e.g.: 'www.storefront.com/2015/12/29/this-new-blog-post'.

The [Spree Editor](http://github.com/spree/spree_editor/) extension can be used to provide a rich text experience when editing the body of a blog entry.

The author is an instance of `Spree.user_class`, typically a `Spree::User`. The author can be selected from users with the `blogger` role when editing a blog entry in the admin.

Admin users can preview blog entries before they're made visible.
Admin users can, further, make entire blogs or individual blog posts private/public.

The code for this engine is based on code from https://github.com/stefansenk/spree-blogging-spree, with several additions and customizations.


Installation
------------

Add to your Gemfile:

```ruby
gem 'spree_multi_blogs', github: 'mehadesai/spree_multi_blogs'
```

Bundle your dependencies and run the installation generator:

```shell
    bundle install
    rake railties:install:migrations
    rake db:migrate
```
-or-

Copy migrations from db/migrate into the db/migrate of your application, appending a .spree_multi_blogs.rb at the end of each migration file:
Follow that up with a db:migrate, and finally a bundle install
```shell
    cp spree_multi_blogs/db/migrate/20150916110923_create_spree_blogs.rb your_app/db/migrate/20150916110923_create_spree_blogs.spree_multi_blogs.rb
    cp spree_multi_blogs/db/migrate/20150917172102_create_spree_user_details.rb your_app/db/migrate/20150917172102_create_spree_user_details.spree_multi_blogs.rb
    cp spree_multi_blogs/db/migrate/20151202171424_create_spree_blogs_access.rb your_app/db/migrate/20151202171424_create_spree_blogs_access.spree_multi_blogs.rb
    cp spree_multi_blogs/db/migrate/20151229123517_create_blog_entries.rb your_app/db/migrate/20151229123517_create_blog_entries.spree_multi_blogs.rb

    rake db:migrate
    bundle install
```

Optional: If you wish to seed your database with blog data, please copy the seed file from the spree_mutli_blog repository into the lib directory in your app and run the db:seed command, as shown below:
Don't forget to include FFaker in your application's Gemfile.

```ruby
group :development, :test do
  gem 'ffaker'
end
```

```shell
cp spree_multi_blogs/db/seeds/spree_multi_blogs_seed.rb your_app/db/seeds/spree_multi_blogs_seed.rb
bundle exec rake db:seed:spree_multi_blogs_seed
```

Don't forget to add 'blogger' as a new role in /admin/roles!

TODO
----
- Tests

- Tags
- Categories
- Integration with Disqus for comments
- Explore mechanisms for dealing with spam comments

- Improved access control on viewing blog posts
- Allow searching for blog entries from the shop front end.
- Get default per page from preferences.
- Add abilities for the 'blogger' role, so a blogger can only manage their own blog entries within the admin.
