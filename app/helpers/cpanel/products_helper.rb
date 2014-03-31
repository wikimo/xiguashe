module Cpanel::ProductsHelper
	def format_source(product)
		product.source.nil? ? 'default' : product.source
	end
end