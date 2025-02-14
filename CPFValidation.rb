def valid_cpf?(cpf)
  # Remove non-numeric characters
  cpf.gsub!(/\D/, '')

  # Check if it has exactly 11 digits
  return false unless cpf.length == 11

  # Reject CPFs with all identical digits
  return false if cpf.chars.uniq.length == 1

  # Convert to an array of integers
  numbers = cpf.chars.map(&:to_i)

  # Calculate the first check digit
  first_digit = calculate_check_digit(numbers[0..8], 10)
  return false unless first_digit == numbers[9]

  # Calculate the second check digit
  second_digit = calculate_check_digit(numbers[0..9], 11)
  return false unless second_digit == numbers[10]

  true
end

def calculate_check_digit(numbers, weight)
  sum = numbers.each_with_index.sum { |num, index| num * (weight - index) }
  remainder = sum % 11
  remainder < 2 ? 0 : 11 - remainder
end

# Get CPF from user input
print "Enter a CPF number: "
user_cpf = gets.chomp

# Validate and display the result
if valid_cpf?(user_cpf)
  puts "The CPF #{user_cpf} is valid."
else
  puts "The CPF #{user_cpf} is invalid."
end
