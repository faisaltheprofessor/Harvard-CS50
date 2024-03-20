#include <math.h>
#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

float getAverageLettersPer100Words(string s);
float getAverageSentencesPer100Words(string s);
int calculateReadabilityScore(string s);


int main()
{
    string input = get_string("Enter the text: ");
    printf("%i\n",calculateReadabilityScore(input));

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




// int getNoOfWords(string s)
// {
//     int noOfWords = 0;
//     for (int i = 0, length = strlen(s); i <= length; i++)
//         {
//             if (isspace(s[i]))
//             {
//                 noOfWords ++;
//             }
//         }
//     return (noOfWords + 1);

// }

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

    return ceil(0.0588 * getAverageLettersPer100Words(s) - 0.296 * getAverageSentencesPer100Words(s) - 15.8);
}
