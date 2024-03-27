#include <stdio.h>
#include <stdlib.h>

#define BLOCK_SIZE 512
#define

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

    int no_of_images_found = 0;
    FILE * image = NULL;
    bool found = false;




     // While there's still data left to read from the memory card
     while(fread(buffer, sizeof(buffer), BLOCK_SIZE, memory_card) == BLOCK_SIZE)
        // Create JPEGs from the data
        if(buffer[0] == 0xFF)


}
