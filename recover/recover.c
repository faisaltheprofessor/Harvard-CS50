#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{

    if(argc != 2)
    {
        printf("Usage: ./recover FILE\n");
        return 1;
    }

     // Open the memory card
    FILE *card = fopen(argv[1], "r");


     // While there's still data left to read from the memory card

        // Create JPEGs from the data


}
