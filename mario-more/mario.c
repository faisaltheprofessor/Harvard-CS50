#include <cs50.h>
#include <stdio.h>

int main()
{
    int height;
    do
    {
        height = get_int("Height: ");
        if (height == )
        {
            break;
        }
    }
    while (height>=9 || height<0);

    for (int i = 1; i<=height; i++)
    {
        printf("#");
    }
    return 0;
}
