require 'spree_core'
require 'spree_multi_blogs/engine'
require 'spree_multi_blogs/spree_multi_blogs_ability'

class Spree::MultiBlogsRoutes
  def self.matches?(request)
    puts "-----------------#{request.path}"
    if request.path =~ /(^\/+(admin|account|cart|checkout|content|login|pg\/|orders|products|s\/|session|signup|shipments|states|tax_categories|user)+)/
      false
    else
      # use [1..-1] to remove leading slash
      !Spree::BlogEntry.unscoped.find_by_permalink(request.path[1..-1]).nil?
    end
  end
end
