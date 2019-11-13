



class Token

    attr_accessor :type, :value

    def initialize(type, value)
      @type = type
      @value = value
    end 

end

class Lexer

  attr_accessor :data, :rules, :regex_parts, :position , :regex_str

  def initialize(rules)
      @position = 0
      @rules = rules
      @regex_parts = []
      @regex_str 
          
      rules.each do |regex_value|
        regex = regex_value[0]
        type  = regex_value[1]
        @regex_parts.push("(?<#{type}>#{regex})" )
      end

      @regex_str = @regex_parts.join("|")
  end

  def input data
    @data = data
    @position = 0
  end

  def token
    if  @position >= @data.length 
      return Token.new nil, nil 

    else
    data = @data[@position..-1]
    matched = data.match(@regex_str)
    @position += matched.end(0)
    lex = matched.named_captures.each do |key, value| 
      if value != nil 
        break Token.new key, value 
       end
    end
    return lex
    end
  end
end


#matched = input_str.match(regex_str)

