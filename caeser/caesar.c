#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

void encrypt_text(string text, int key);

int main(int argc, string argv[])
{
    // Validate arguments
    if (argc != 2)
    {
        printf("Usage: ./caesar key\n");
        return 1;
    }

    int key = atoi(argv[1]) % 26;

    // Input text from user
    string text = get_string("Enter Text: ");

    // Encrypt the text
    encrypt_text(text, key);
}

void encrypt_text(string text, int key)
{
    for (int i = 0; i < strlen(text); i++)
    {
        if (isalpha(text[i]))
        {
            if (islower(text[i]))
            {
                printf("%c", ((((text[i] - 'a') + key) % 26) + 'a'));
            }
            else
            {
                printf("%c", ((((text[i] - 'A') + key) % 26) + 'A'));
            }
        }
        else
        {
            printf("%c", text[i]);
        }
    }
}
