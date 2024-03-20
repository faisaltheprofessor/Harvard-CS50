#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

int main(int argc, string argv[])
{
    // Handling lack of arguments
    if (argc != 2)
    {
        printf("Usage: ./caesar key\n");
        return 1;
    }

    int k = atoi(argv[1]) % 26; // Ensure key is within the range of letters

    // Prompting the user for text
    string prompt = get_string("Enter Text: ");

    for (int i = 0; i < strlen(prompt); i++)
    {
        // In case of alphabets
        if (isalpha(prompt[i]))
        {
            // In case of upper case letters
            if (islower(prompt[i]))
            {
                printf("%c", ((((prompt[i] - 'a') + k) % 26) + 'a');
            }
            else
            {
                // In case of lower case letters
                printf("%c", ((((prompt[i] - 'A') + k) % 26) + 'A');
            }
        }
        else
        {
            // In case of non-alphabets
            printf("%c", prompt[i]);
        }
    }
}
