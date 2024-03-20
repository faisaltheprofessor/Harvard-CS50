#include <math.h>
#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

int getNoOfLettersAndWords(string s, int* totalWords);
int getNoOfWords(string s);
float getAverageSentencesPer100Words(string s)
int calculateReadabilityScore(string s);


int main()
{
    string input = get_string("Enter the text: ");

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

float getAverageSentencesPer100Words(string s)
{
    int noOfSentences = 0;
    int totalWords = 0;

    for (int i = 0, length = strlen(s); i < length; i++)
    {
        if (s[i] == '.' || s[i] == '?' || s[i] == '!')
        {
            noOfSentences++;
        }
        else if (isspace(s[i]))
        {
            totalWords++;
        }
    }

    // Increment total words by 1 for the last word
    totalWords++;

    float averageSentencesPer100Words = ((float) noOfSentences / totalWords) * 100;

    return averageSentencesPer100Words;
}


int calculateReadabilityScore(string s)
{

    return ceil(0.0588 * getNoOfLetters(s) - 0.296 * getNoOfSentences(s) - 15.8);
}
