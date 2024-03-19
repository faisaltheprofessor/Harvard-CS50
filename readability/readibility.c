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
    printf("%i", getNoOfLetters(input));

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
}




int getNoOfWords(string s)
{
    int noOfWords = 0;


}

int getNoOfSentences(string s)
{
    int noOfSentences = 0;


}

int calculateReadabilityScore(string s)
{
    int score;


}
