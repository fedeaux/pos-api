module FactoryGirl
  module Syntax
    module Methods
      def create_or_find_user(user_factory)
        create_or_find_by(User, user_factory, :email)
      end
    end
  end
end
