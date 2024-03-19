#include <math.h>
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
    printf("no of letters: %i\n", getNoOfLetters(input));

    printf("no of words: %i\n", getNoOfWords(input));

    printf("no of sentences: %i\n", getNoOfSentences(input));

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

    return ceil(0.0588 * getNoOfLetters(s) - 0.296 * getNoOfSentences(s) - 15.8);
}
