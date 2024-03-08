compute_value() {
  echo "Enter the first number:"
  read -r num1

  echo "Enter the second number:"
  read -r num2

  result=$((num1 + num2))
}

# Call the subroutine and capture the result using command substitution
compute_value

echo $result
