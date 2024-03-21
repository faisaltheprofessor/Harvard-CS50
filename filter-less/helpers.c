#include "helpers.h"
#include <stdio.h>

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i<height; i++)
    {
        for(int j=0; j<width; j++)
        {
            RGBTRIPLE pixel = image[i][j];
            int rgbtRed = pixel.rgbtRed;
            int rgbtGreen = pixel.rgbtGreen;
            int rgbtBlue = pixel.rgbtBlue;

            int avg = (rgbtRed + rgbtGreen + rgbtBlue) / 3;

            image[i][j].rgbtRed = avg;
            image[i][j].rgbtGreen = avg;
            image[i][j].rgbtBlue = avg;

        }
    }
}

// Convert image to sepia
void sepia(int height, int width, RGBTRIPLE image[height][width])
{
            for(int j=0; j<width; j++)
        {
            RGBTRIPLE pixel = image[i][j];
            int rgbtRed = pixel.rgbtRed;
            int rgbtGreen = pixel.rgbtGreen;
            int rgbtBlue = pixel.rgbtBlue;

            int avg = (rgbtRed + rgbtGreen + rgbtBlue) / 3;

            image[i][j].rgbtRed = avg;
            image[i][j].rgbtGreen = avg;
            image[i][j].rgbtBlue = avg;

        }

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
