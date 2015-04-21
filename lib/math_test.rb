class MathTest

  CORRECT   = "correct"
  WRONG     = "wrong"
  EQU_REGEX = /\s*-?\d+(?:\s*[-\+\*\/]\s*\d+)+/
  NUM_REGEX = /[^(@[a-zA-Z0-9]*)]\d+/

  # Simple two-number equation generator
  def self.genarate_equation
    max = 100
    operators = ['+', '-', '*', '/']
    return rand(1..max).to_s + operators[rand(operators.length)] + rand(max).to_s
  end

  # Parse equation out of a string with alphabetic characters
  def self.parse_equation(str=nil)
    return str.nil? ? nil : str.scan(EQU_REGEX).first
  end

  def self.parse_number(str=nil)
    return str.nil? ? nil : str.scan(NUM_REGEX).first
  end

  # Evaluate an quation and make sure the answer is right
  def self.validate_answer(question=nil, answer=nil)
    if question.nil? || answer.nil?
      return WRONG
    else
      eval_question = eval(parse_equation(question))
      eval_answer = eval(parse_number(answer))
      return eval_question == eval_answer ? CORRECT : WRONG
    end
  end


end