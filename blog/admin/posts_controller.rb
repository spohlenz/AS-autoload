module Blog
  module Admin
    class PostsController
      def self.hardcoded
        Post.new
      end
      
      def self.autodetect
        namespaced_class = self.name.sub(/Controller/, '').singularize
        namespaced_class.constantize.new
      end
    end
  end
end
