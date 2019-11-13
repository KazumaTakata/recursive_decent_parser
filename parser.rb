


require_relative "./lexer.rb"




rules = [
      ['set', 'SET'  ],
      ['\d+' , 'NUMBER'],
      [ '[a-zA-Z_]\w*', 'IDENTIFIER'],
      [  '\+', 'PLUS' ],
      [  '\-', 'MINUS' ],
      [  '\*', 'MUL' ],
      [  '\/', 'DIV'  ],
      ['=', 'EQUAL']    
]




input_str = "set x = 3"


lexer = Lexer.new(rules)

class Parser 

  attr_accessor :cur_token, :table, :lexer

  def initialize(lexer)
    @lexer = lexer
    @cur_token = nil
    @table = {}
  end
    
  def eat_token(token_type)
    if @cur_token.type != token_type
      raise "type mismatch #{token.type} != #{token_type} "
    else
      val = @cur_token.value
      @cur_token = @lexer.token
      val  
    end
  end

  def get_nexttoken 
    @cur_token = @lexer.token
  end

  def get_curtoken
    @cur_token
  end


  def parse input_data
    @lexer.input input_data
    get_nexttoken
    return parse_stmt
  end

  def parse_stmt
    if @cur_token.type == "SET"
      eat_token "SET"
      ident = eat_token "IDENTIFIER" 
      eat_token "EQUAL"
      expr_val = parse_expr
      @table[ident] = expr_val
      return expr_val
    else 
      parse_expr
    end

  end


  def parse_expr 
    term1 = parse_term

    if @cur_token.type == "PLUS" 
        eat_token "PLUS"
        term2 = parse_term    
        return term1 + term2

    else
      if @cur_token.type == "MINUS"
        eat_token "MINUS"
        term2 = parse_term
        return term1 - term2
      else 
        return term1
      end
    end

  end


  def parse_term
    factor1 = parse_factor

    if @cur_token.type == "MUL" 
        eat_token "MUL"
        factor2 = parse_factor    
        return factor1 * factor2
    else 
      if @cur_token.type == "DIV"
        eat_token "DIV"
        factor2 = parse_factor
        return factor1 / factor2
      else 
        return factor1
      end
    end

  end
  


  def parse_factor
    if @cur_token.type == "IDENTIFIER"
      ident = eat_token "IDENTIFIER"  
      val = @table[ident]
    else 
      if @cur_token.type == "NUMBER"
        num_str = eat_token "NUMBER"
        num_str.to_i
      end
    end
  end



end


parser = Parser.new lexer



