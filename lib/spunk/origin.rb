module Spunk
  class Origin
    attr_accessor :prefix

    def initialize(prefix)
      @prefix = prefix
    end

    def nickname
      @prefix.to_s.split(/!/, 2).first
    end
    
    def username
      @prefix.to_s.split(/!/, 2)[1].split("@").first
    end

    def to_s
      case
      when nickname != ""
        nickname
      when @prefix
        @prefix
      end
    end
  end
end