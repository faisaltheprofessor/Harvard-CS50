#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

int getNoOfLetters(string s);
int getNoOfWords(string s);
int getNoOfSentences(string s);
int calculateReadabilityScore(string s);


int main()
{
    string input = get_string("Enter the text: ");
    printf("%i", getNoOfSentences(input));

}



int getNoOfLetters(string s)
{
    int noOfLetters = 0;
    for (int i = 0, length = strlen(s); i <= length; i++)
    {
        if (isalpha(s[i]))
        {
            noOfLetters ++;
        }
    }
    return noOfLetters;
}




int getNoOfWords(string s)
{
    int noOfWords = 0;
    for (int i = 0, length = strlen(s); i <= length; i++)
        {
            if (isspace(s[i]))
            {
                noOfWords ++;
            }
        }
    return noOfWords + 1;

}

int getNoOfSentences(string s)
{
    int noOfSentences = 0;

     for (int i = 0, length = strlen(s); i <= length; i++)
        {
            if (s[i] == '.' || s[i] == '?' || s[i] == '!')
            {
                noOfSentences ++;
            }
        }

    return noOfSentences;

}

int calculateReadabilityScore(string s)
{


    return 0.0588 * ;
}
