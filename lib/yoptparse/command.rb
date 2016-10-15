module Yoptparse
  class Command
    class << self
      # @return [String]
      def banner
        ::YARD::Registry.at("#{self}#initialize").docstring
      end

      # @param argv [Array<String>]
      # @return [Yoptparse::Command]
      def parse(argv)
        option_parser, result_store = generate_option_parser_and_result_store
        option_parser.parse(argv)
        new(result_store)
      end

      # @return [OptionParser]
      def to_option_parser
        generate_option_parser_and_result_store.first
      end

      private

      # @return [String]
      def constructor_path
        instance_method(:initialize).source_location.first
      end

      # @return [Array]
      def generate_option_parser_and_result_store
        load_constructor_documentation
        result_store = {}
        option_parser = ::OptionParser.new
        option_parser.banner = banner
        instance_method(:initialize).parameters.map do |argument_type, argument_name|
          option = ::Yoptparse::Option.new(
            argument_name: argument_name,
            argument_type: argument_type,
            command_class: self,
          )
          option_parser.on(
            option.long_option,
            option.type_class,
            option.description,
          ) do |value|
            result_store[argument_name] = value
          end
        end
        [option_parser, result_store]
      end

      # @return [void]
      def load_constructor_documentation
        ::YARD.parse(constructor_path)
      end
    end
  end
end
