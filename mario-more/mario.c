#include <cs50.h>
#include <stdio.h>
#include <string.h>

int main()
{
    string height_in_str;
    int height;
    do
    {
        height_in_str = get_string("Height: ");
        if ( strlen(height_in_str) == 0)
        {
            break;
        }
        height = atoi(height_in_str);
    }
    while (height>=9 || height<0);

    for (int i = 1; i<=height; i++)
    {
        printf("#");
    }
    return 0;
}
