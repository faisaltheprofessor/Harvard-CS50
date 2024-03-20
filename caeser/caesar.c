#include <cs50.h>
#include <stdio.h>
#include "string.h"
#include "ctype.h"
#include "stdlib.h"

int main(int argc, string argv[])
{
    // Handling lack of arguments
    if (argc != 2)
    {
        printf("Usage: ./caesar key\n");
        return 1;
    }
    int k = atoi(argv[1]);
    // Prompting the user for text
    string prompt = get_string("Enter Text: ");

    for (int i = 0; i < strlen(prompt);i++)
    {
    // In case of alphabets
        if (isalpha(prompt[i]))
        {
            // In case of upper case letters
            if (islower(prompt[i]))
            {
                printf("%c", ((((prompt[i] - 97) + k) % 26) + 97));
            }

            else
            {
                // In case of lower case letters
                printf("%c", ((((prompt[i] - 65) + k) % 26) + 65));
            }
        }

        else
        {
            // In case of non-alphabets
            printf("%c", prompt[i]);
        }

    }
    // Printing a new line after the loop execution has finished
    printf("\n");
}
