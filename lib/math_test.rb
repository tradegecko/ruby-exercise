class MathTest

  CORRECT   = "correct"
  WRONG     = "wrong"
  EQU_REGEX = /\s*-?\d+(?:\s*[-\+\*\/]\s*\d+)+/

  # Simple two-number equation generator
  def self.genarate_equation
    max = 100
    operators = ['+', '-', '*', '/']
    return rand(1..max).to_s + operators[rand(operators.length)] + rand(max).to_s
  end

  # Parse equation out of a string with alphabetic characters
  def self.parse_equation(equation_str=nil)
    return nil if equation_str.nil?
    return EQU_REGEX.match(equation_str).to_s
  end

  # Evaluate an quation and make sure the answer is right
  def self.validate_answer(question=nil, answer=nil)
    if question.nil? || answer.nil?
      return WRONG
    else
      return (eval(parse_equation(question)) == answer.to_i ? CORRECT : WRONG)
    end
  end


end