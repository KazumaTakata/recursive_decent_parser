


class Lexer

  attr_accessor :data, :rules, :regex_parts, :position , :regex_str

  def initialize(input_data, rules)
      @position = 0
      @data = input_data
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


  def token
    data = @data[@position..-1]
    matched = data.match(@regex_str)
    @position = matched.end(0)
    return matched
  end

end


rules = [
      ['\d+' , 'NUMBER'],
      [ '[a-zA-Z_]\w*', 'IDENTIFIER'],
      ['=', 'EQUAL']    
]




input_str = "x=3"


lexer = Lexer.new(input_str, rules)


#matched = input_str.match(regex_str)

