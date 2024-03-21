#include "helpers.h"
#include <stdio.h>

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i<height; i++)
    {
        for(int j=0; j<width; j++)
        {
            int rgbtRed = image[i][j].rgbtRed;
            int rgbtGreen = image[i][j].rgbtGreen;
            int rgbtBlue = image[i][j].rgbtBlue;

            int avg = (rgbtRed + rgbtGreen + rgbtBlue) / 3;

            image[i][j].rgbtRed = avg;
            image[i][j].rbgtGreen = avg;
            image[i][j].rgbtBlue = avg;

        }
    }
}

// Convert image to sepia
void sepia(int height, int width, RGBTRIPLE image[height][width])
{
    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    return;
}
