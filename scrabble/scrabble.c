#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

typedef struct
{
    char character;
    int weight;
}
letter;

letter letters[26] = {
    {'A', 1},
    {'B', 3},
    {'C', 3},
    {'D', 2},
    {'E', 1},
    {'F', 4},
    {'G', 2},
    {'H', 4},
    {'I', 1},
    {'J', 8},
    {'K', 5},
    {'L', 1},
    {'M', 3},
    {'N', 1},
    {'O', 1},
    {'P', 3},
    {'Q', 10},
    {'R', 1},
    {'S', 1},
    {'T', 1},
    {'U', 1},
    {'V', 4},
    {'W', 4},
    {'X', 8},
    {'Y', 4},
    {'Z', 10}
};


int calculateScore(string s);
int getIndex(char c);

int main()
{

    string player1Word = get_string("Player 1: ");
    string player2Word = get_string("Player 2: ");

    int player1Score;
    int player2Score;

    player1Score = calculateScore(player1Word);
    player2Score = calculateScore(player2Word);

    if (player1Score == player2Score)
    {
        printf("Tie!");
    }
    else if (player1Score > player2Score)
    {
        printf("Player 1 wins!");
    }
    else if (player1Score < player2Score)
    {
        printf("Player 2 wins!");
    }
}

int calculateScore(string s)
{
    int score = 0;
    for (int i = 0; i < strlen(s); i++)
    {
        char currentLetter = s[i];
        score += weights[getIndex(currentLetter)];
    }
    return score;
}

int getIndex(char c)
{
    int index = -1;

    for (int i = 0, length = sizeof(letters) / sizeof(letters[0]); i < length; i++)
    {
        if (toupper(c) == letters[i].character)
        {
            index = i;
            break;
        }
    }
    return index;
}
