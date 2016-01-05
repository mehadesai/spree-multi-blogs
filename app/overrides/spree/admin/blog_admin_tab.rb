Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  name: 'admin_blog_tab',
  insert_bottom: '[data-hook=admin_tabs]',
  partial: 'spree/admin/shared/blog_menu',
  disabled: false
)
