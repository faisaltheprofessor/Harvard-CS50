#include <cs50.h>
#include <stdio.h>
#include <string.h>

int main(void)
{
    int change;
    int no_of_coins = 0;

    do
    {
        change = get_int("Change owed: ");
    }
    while (change < 0);

    while (change > 0)
    {
        if (change >= 25)
        {
            change = change - 25;
            no_of_coins++;
            printf("%i\n", 25);
        }

        else if (change >= 10)
        {
            change = change - 10;
            no_of_coins++;
             printf("%i\n", 10);
        }

        else if (change >= 5)
        {
            change = change - 5;
            no_of_coins++;
             printf("%i\n", 5);
        }

        else if (change >= 1)
        {
            change = change - 1;
            no_of_coins++;
            printf("%i\n", 1);
        }
    }

    printf("%i\n", no_of_coins);
}
