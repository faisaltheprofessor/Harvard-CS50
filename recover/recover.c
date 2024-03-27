#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define BLOCK_SIZE 512
#define JPEG_START1 0xff
#define JPEG_START2 0xd8
#define JPEG_HEADER_MASK 0xf0
#define JPEG_HEADER_VALUE 0xe0

int main(int argc, char *argv[])
{

    if(argc != 2)
    {
        printf("Usage: ./recover FILE\n");
        return 1;
    }

     // Open the memory card
    FILE *memory_card = fopen(argv[1], "r");

    if (memory_card == NULL)
    {
        printf("Could not open file \n");
        return 2;
    }

   uint8_t buffer[BLOCK_SIZE];
    int img_count = 0;
    FILE *img = NULL;
    bool jpeg_found = false;

    while (fread(buffer, 1, BLOCK_SIZE, memory_card) == BLOCK_SIZE)
    {
        if (buffer[0] == JPEG_START1 && buffer[1] == JPEG_START2 && buffer[2] == JPEG_START1 && (buffer[3] & JPEG_HEADER_MASK) == JPEG_HEADER_VALUE)
        {
            if (jpeg_found)
            {
                fclose(img);
            }
            else
            {
                jpeg_found = true;
            }

            char filename[8];
            sprintf(filename, "%03i.jpg", img_count);
            img = fopen(filename, "w");
            img_count++;
        }

        if (jpeg_found)
        {
            fwrite(buffer, 1, BLOCK_SIZE, img);
        }
    }

    fclose(memory_card);
    if (img != NULL)
    {
        fclose(img);
    }

    return 0;


}
