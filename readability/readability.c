#include <cs50.h>
#include <ctype.h>
#include <math.h>
#include <stdio.h>
#include <string.h>

float getAverageLettersPer100Words(string s);
float getAverageSentencesPer100Words(string s);
int calculateReadabilityScore(string s);

int main()
{
    string input = get_string("Enter the text: ");
    int score = calculateReadabilityScore(input);
    if (score < 1)
    {
        printf("Before Grade 1\n");
    }
    else if (score >= 16)
    {
        printf("Grade 16+\n");
    }
    else
    {
        printf("Grade %i\n", score);
    }
}

float getAverageLettersPer100Words(string s)
{
    int totalWords = 0;
    int totalLetters = 0;

    for (int i = 0, length = strlen(s); i < length; i++)
    {
        if (isalpha(s[i]))
        {
            totalLetters++;
        }
        else if (isspace(s[i]))
        {
            totalWords++;
        }
    }

    // Increment total words by 1 for the last word
    totalWords++;

    // Calculate average letters per word
    float averageLettersPerWord = (float) totalLetters / totalWords;

    // Calculate average letters per 100 words
    float averageLettersPer100Words = averageLettersPerWord * 100;

    return averageLettersPer100Words;
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

    float lettersPer100Words = getAverageLettersPer100Words(s);
    float sentencesPer100Words = getAverageSentencesPer100Words(s);

    float score = 0.0588 * lettersPer100Words - 0.296 * sentencesPer100Words - 15.8;

    float decimalPart = score - (int) score;
    if (decimalPart >= 0.5)
    {
        return ceil(score);
    }
    else
    {
        return floor(score);
    }
}
