/*
 * Copyright (C) 2019 Elisa Rojas(1), Hedayat Hosseini(2), and David Carrascal(1);
 *                    (1) GIST, University of Alcala, Spain.
 *                    (2) CEIT, Amirkabir University of Technology (Tehran
 *                        Polytechnic), Iran.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define CONDITION_MAX 2
#define MAX_LINE_LEN 500
//#define MOTE_TYPE 1 //SKY
//#define MOTE_TYPE 2 //COOJA
#define MOP 1 //1:storing, 2:nonstoring

char old_line1[MAX_LINE_LEN], new_line1[MAX_LINE_LEN];
char old_line2[MAX_LINE_LEN], new_line2[MAX_LINE_LEN];


int main(int argc, char *argv[])
{
    FILE *fp;

    char destfile[100];
    int sim_parser(FILE *, char *);
#if MOP == 1
  strcpy(old_line1, "     <source>[CONTIKI_DIR]/examples/rpl-storing/sky-testscript/code/sink.c</source>");
  strcpy(new_line1, "     <source>[CONTIKI_DIR]/examples/rpl-storingHC/sky-testscript/code/sink.c</source>\n");

  strcpy(old_line2, "      <source>[CONTIKI_DIR]/examples/rpl-storing/sky-testscript/code/mote.c</source>");
  strcpy(new_line2, "      <source>[CONTIKI_DIR]/examples/rpl-storingHC/sky-testscript/code/mote.c</source>\n");
#elif MOP == 2
    strcpy(old_line1, "     <source>[CONTIKI_DIR]/examples/rpl-non-storing/sky-testscript/code/sink.c</source>");
    strcpy(new_line1, "     <source>[CONTIKI_DIR]/examples/rpl-non-storingHC/sky-testscript/code/sink.c</source>\n");

    strcpy(old_line2, "      <source>[CONTIKI_DIR]/examples/rpl-non-storing/sky-testscript/code/mote.c</source>");
    strcpy(new_line2, "      <source>[CONTIKI_DIR]/examples/rpl-non-storingHC/sky-testscript/code/mote.c</source>\n");
#endif

    printf("\nSim changer 2019\n\n");

    if (argc==1)
    {
        fprintf(stderr,"\nNo simulation file introduced\n");
    }
    else{
            if ((fp= fopen(*++argv,"r"))==NULL){
                fprintf(stderr,"\nCan't open %s\n",*argv);
                return 0;
            }else{
                system("mkdir new-sim");
                strcat(strcpy(destfile, "new-sim/"), *argv);
                if (sim_parser(fp, destfile))
                    printf("\nNew simulation files were generated successfully.\n");
                else
                    printf("\nNew file is not generated successfully! please try again.\n");
                fclose(fp);
            }

    }

    return 1;
}
/*---------------------------------------------------------------------------*/
int sim_parser(FILE *fp, char *destfile){

    char line[MAX_LINE_LEN];
    int i,common_check=0,check_condition[CONDITION_MAX];

    FILE *destfp;
    if((destfp=fopen(destfile,"w"))==NULL){
       fprintf(stderr,"\nCan't open destination file (%s)\n",destfile);
       return 0;

       }else{
           //fprintf(destfp,"** This file was generated by  parser **\n\n");

           while (fgets(line,MAX_LINE_LEN,fp)){
                for(i=0;i<CONDITION_MAX;i++)
                    check_condition[i]=0;
                common_check = 1;
                check_condition[0] = common_check && (strstr(line,old_line1));
                check_condition[1] = common_check && (strstr(line,old_line2));

                if(check_condition[0]){
                  fputs(new_line1, destfp);
                }else if(check_condition[1]){
                  fputs(new_line2, destfp);
                }else
                  fputs(line, destfp);

           }//END while
           fclose(destfp);
       }
       return 1;
}
