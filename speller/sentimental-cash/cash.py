from cs50 import get_float

while True:
    change = get_float("Change: ")
    if(change > 0):
        break

noOfCoins = 0

changeInCents = change * 100
while changeInCents != 0:
    if changeInCents >= 25:
        changeInCents = changeInCents - 25
        noOfCoins = noOfCoins + 1

    elif changeInCents >= 10:
        changeInCents = changeInCents - 10
        noOfCoins = noOfCoins + 1

    elif changeInCents >= 5:
            changeInCents = changeInCents - 5
            noOfCoins = noOfCoins + 1

    elif changeInCents >= 1:
                changeInCents = changeInCents - 1
                noOfCoins = noOfCoins + 1

print(noOfCoins)
