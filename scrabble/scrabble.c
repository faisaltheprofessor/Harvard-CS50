#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

char letters[26] = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
int weights[26] = {1,3,3,2,1,4,2,4,1,8,5,1,3,1,1,3,10,1,1,1,1,4,4,8,4,10};

int calculateScore(string s);
int getIndex(char c);

int main()
{


    string player1Word = get_string("Player 1: ");
    string player2Word = get_string("Player 2: ");


    int  player1Score;
    int player2Score;

    player1Score = calculateScore(player1Word);
    player2Score =  calculateScore(player2Word);

    printf("Player 1 score: %i \nPlayer 2 score: %i", player1Score, player2Score);
}


int calculateScore(string s)
{
    int score = 0;
    for(int i = 0; i < strlen(s); i++) {
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
        if (toupper(c) == letters[i])
        {
            index = i;
            break;
        }
    }
    return index;
}
