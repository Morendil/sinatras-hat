module Sinatra
  module Hat
    class Maker
      include Sinatra::Hat::Extendor
      
      attr_reader :klass, :app
      
      def initialize(klass, overrides={})
        @klass = klass
        options.merge!(overrides)
        with(options)
      end
      
      def setup(app)
        @app = app
        generate_routes(app)
      end
      
      def handle_index(request)
        data = model.all(request.params)
        
        request.params[:format] ?
          responder.serialize(data, request) :
          responder.render(:index, request, data)
      end
      
      def handle_show(request)
        data = model.find(request.params)
        
        request.params[:format] ?
          responder.serialize(data, request) :
          responder.render(:show, request, data)
      end
      
      def prefix
        @prefix ||= options[:prefix] || model.plural
      end
      
      def parents
        @parents ||= parent ? Array(parent) + parent.parents : []
      end
      
      def resource_path(suffix)
        resource.path(suffix)
      end
      
      def options
        @options ||= {
          :finder => proc { |model, params| model.all },
          :record => proc { |model, params| model.first(:id => params[:id]) },
          :parent => nil,
          :formats => { }
        }
      end
      
      def inspect
        "maker: #{klass}"
      end
      
      def generate_routes(app)
        Router.new(self).generate(app)
      end
      
      def responder
        @responder ||= Responder.new(self)
      end
      
      def model
        @model ||= Model.new(self)
      end
      
      private
      
      def resource
        @resource ||= Resource.new(self)
      end
    end
  end
end