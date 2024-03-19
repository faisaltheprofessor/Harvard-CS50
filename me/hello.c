#include <cs50.h>
#include <stdio.h>

int main()
{
    string name = get_string("Enter your name: ");
    printf("hello, %s\n", name);
    return 0;
}
