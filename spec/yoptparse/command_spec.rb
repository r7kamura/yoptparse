class ExampleClass < Yoptparse::Command
  # Usage: somemoji extract [options]
  # @param destination [String] Directory path to put extracted emoji images
  # @param format [String] png or svg (default: png)
  # @param provider [String] Emoji provider name (apple, emoji_one, noto or twemoji)
  # @param quiet [Boolean] Disable log output
  # @param size [Integer] Image size
  def initialize(destination:, format: "png", provider:, quiet: false, size: 64)
    @destination = destination
    @format = format
    @provider = provider
    @quiet = quiet
    @size = size
  end
end

RSpec.describe Yoptparse::Command do
  let(:command_class) do
    ::ExampleClass
  end

  describe ".to_option_parser" do
    subject do
      command_class.to_option_parser
    end

    it "returns an OptionParser instance from #initialize arguments and its YARD style documentation" do
      expect(subject.to_s).to eq <<-TEXT.strip_heredoc
        Usage: somemoji extract [options]
                --destination=               Directory path to put extracted emoji images (required)
                --provider=                  Emoji provider name (apple, emoji_one, noto or twemoji) (required)
                --format=                    png or svg (default: png)
                --quiet                      Disable log output
                --size=                      Image size
      TEXT
    end
  end
end
