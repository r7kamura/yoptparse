module Yoptparse
  class Option
    # @param argument_name [Symbol]
    # @param argument_type [Symbol]
    # @param command_class [Class]
    def initialize(argument_name:, argument_type:, command_class:)
      @argument_name = argument_name
      @argument_type = argument_type
      @command_class = command_class
    end

    # @return [String]
    def description
      [description_main, description_suffix].compact.join(" ")
    end

    # @return [String]
    def long_option
      "--#{chain_cased_argument_name}#{long_option_suffix}"
    end

    # @return [Class]
    def type_class
      case tag.type
      when "Array"
        ::Array
      when "Float"
        ::Float
      when "Integer"
        ::Integer
      when "Numeric"
        ::Numeric
      when "OptionParser::DecimalInteger"
        ::OptionParser::DecimalInteger
      when "OptionParser::DecimalNumeric"
        ::OptionParser::DecimalNumeric
      when "OptionParser::OctalInteger"
        ::OptionParser::OctalInteger
      when "String"
        ::String
      else
        ::Object
      end
    end

    private

    # @return [Boolean]
    def boolean?
      tag.type == "Boolean"
    end

    # @return [String]
    def chain_cased_argument_name
      @argument_name.to_s.gsub("_", "-")
    end

    # @return [String, nil]
    def description_main
      if tag
        tag.text
      end
    end

    # @return [String, nil]
    def description_suffix
      if required?
        "(required)"
      end
    end

    # @return [String, nil]
    def long_option_suffix
      unless boolean?
        "="
      end
    end

    # @return [Boolean]
    def required?
      @argument_type == :keyreq
    end

    # @return [YARD::Tag, nil]
    def tag
      ::YARD::Registry.at("#{@command_class}#initialize").tags.find do |tag|
        tag.tag_name == "param" && tag.name == @argument_name.to_s
      end
    end
  end
end
