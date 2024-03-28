from cs50 import get_int


while True:
    height = get_int("Height:")
    if(height <=8 and height > 0):
        break


current = 1
for i in range(height):
    print('#' * current)
    current = current + 1
