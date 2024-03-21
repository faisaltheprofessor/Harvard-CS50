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
     for (int i = 0; i<height; i++)
    {
            for(int j=0; j<width; j++)
        {
            RGBTRIPLE pixel = image[i][j];
            int rgbtRed = pixel.rgbtRed;
            int rgbtGreen = pixel.rgbtGreen;
            int rgbtBlue = pixel.rgbtBlue;

            int sepiaRed = .393 * pixel.rgbtRed + .769 * pixel.rgbtGreen + .189 * pixel.rgbtBlue;
            int sepiaGreen = .349 * pixel.rgbtRed + .686 * pixel.rgbtGreen + .168 * pixel.rgbtBlue;
            int sepiaBlue = .272 * pixel.rgbtRed + .534 * pixel.rgbtGreen + .131 * pixel.rgbtBlue;

            if(sepiaRed > 255) {
                sepiaRed = 255;
            }

             if(sepiaGreen > 255) {
                sepiaGreen = 255;
            }

             if(sepiaBlue > 255) {
                sepiaBlue = 255;
            }
            // printf("red: %i, green:%i, blue: %i", sepiaRed, sepiaGreen, sepiaBlue);
            image[i][j].rgbtRed = sepiaRed;
            image[i][j].rgbtGreen = sepiaGreen;
            image[i][j].rgbtBlue = sepiaBlue;

        }
    }

    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
     for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width / 2; j++)
        {
            // Swap pixels
            RGBTRIPLE temp = image[i][j];
            image[i][j] = image[i][width - 1 - j];
            image[i][width - 1 - j] = temp;
        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
     RGBTRIPLE copy[height][width];
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            copy[i][j] = image[i][j];
        }
    }

    // Loop over all pixels in the original image
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            int redSum = 0;
            int greenSum = 0;
            int blueSum = 0;
            int pixels = 0;

            // Loop over the 3x3 box around the pixel
            for (int k = -1; k <= 1; k++)
            {
                for (int l = -1; l <= 1; l++)
                {
                    int newI = i + k;
                    int newJ = j + l;

                    // Check if the new pixel is within bounds
                    if (newI >= 0 && newI < height && newJ >= 0 && newJ < width)
                    {
                        redSum += copy[newI][newJ].rgbtRed;
                        greenSum += copy[newI][newJ].rgbtGreen;
                        blueSum += copy[newI][newJ].rgbtBlue;
                        pixels++;
                    }
                }
            }

            // Update the pixel values in the original image
            image[i][j].rgbtRed = round((float)redSum / pixels);
            image[i][j].rgbtGreen = round((float)greenSum / pixels);
            image[i][j].rgbtBlue = round((float)blueSum / pixels);
        }
    }

    return;
}
