module FactoryGirl
  module Syntax
    module Methods
      def create_or_find_user(user_factory)
        create_or_find_by(User, user_factory, :email)
      end

      def create_or_find_product_category(product_category_factory)
        create_or_find_by(ProductCategory, product_category_factory, :name)
      end

      def create_or_find_by(model, factory, field)
        model.find_by(field => attributes_for(factory)[field]) || create(factory)
      end
    end
  end
end
