#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


#define BLOCK_SIZE 512
#define JPEG_SIG_1 0xff
#define JPEG_SIG_2 0xd8
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
    bool jpg_found = false;

    while (fread(buffer, 1, BLOCK_SIZE, memory_card) == BLOCK_SIZE)
    {
        if (buffer[0] == JPEG_SIG_1 && buffer[1] == JPEG_SIG_2 && buffer[2] == JPEG_SIG_1 && (buffer[3] & JPEG_HEADER_MASK) == JPEG_HEADER_VALUE)
        {
            if (jpg_found)
            {
                fclose(img);
            }
            else
            {
                jpg_found = true;
            }

            char filename[8];
            sprintf(filename, "%03i.jpg", img_count);
            img = fopen(filename, "w");
            img_count++;
        }

        if (jpg_found)
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
