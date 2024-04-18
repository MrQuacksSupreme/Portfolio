import random

def main():
    name = input(f"What is your name? \n")
    print(f"Welcome to the game {name}")

def game():
    num = random.randint(1,10)
    while True:
        guess = int(input(f"Guess a number 1 through 10? \n"))
        if guess == num:
            print("Correct")
            break
        elif guess > num:
            print("Too high")
        elif guess < num:
            print("Too low")
main()
game()