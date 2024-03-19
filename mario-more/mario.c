#include <cs50.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
    string height_in_str;
    int height;
    do
    {
        height_in_str = get_string("Height: ");
        height = atoi(height_in_str);
    }
    while (height >= 9 || height <= 0);

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
