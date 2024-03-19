#include <cs50.h>
#include <stdio.h>

int main()
{
    int height;
    do
    {
        height = get_int("Height: ");
        if (height <= 0)
        {
            break;
        }
    }
    while (height >= 9 || height < 0);

    for (int i = 1; i <= height; i++)
    {
        for (int k = height - i; k > 0; k--)
        {
            printf(" ");
        }

        for (int j = i; j > 0; j--)
        {
            printf("#");
        }

        printf("  ");

        for (int j = i; j > 0; j--)
        {
            printf("#");
        }

        printf("\n");
    }

    return 0;
}
