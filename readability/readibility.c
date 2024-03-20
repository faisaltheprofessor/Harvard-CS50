#include <math.h>
#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

int getNoOfLettersAndWords(string s, int* totalWords);
int getNoOfWords(string s);
int getNoOfSentences(string s);
int calculateReadabilityScore(string s);


int main()
{
    string input = get_string("Enter the text: ");
    printf("no of letters: %i\n", int getNoOfLettersAndWords(string s, int* totalWords));

    printf("no of words: %i\n", getNoOfWords(input));

    printf("no of sentences: %i\n", getNoOfSentences(input));


    printf("ReadabilityScore is : %f\n", 0.0588 * getNoOfLetters(input) - 0.296 * getNoOfSentences(input) - 15.8);
}



int getNoOfLettersAndWords(string s, int* totalWords)
{
    int noOfLetters = 0;
    *totalWords = 0;

    for (int i = 0, length = strlen(s); i < length; i++)
    {
        if (isalpha(s[i]))
        {
            noOfLetters++;
        }
        else if (isspace(s[i]))
        {
            (*totalWords)++;
        }
    }

    // Increment total words by 1 for the last word
    (*totalWords)++;

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
    return (noOfWords + 1);

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
