#include <stdio.h>

/* simulate fund transfer */
void transfer_fund(FILE *file,
		   char* source_of_fund_secret_token,
		   char* receiver_account_no) {
  // simulate fund transfer
    fprintf(file, "TRANSFERRED TO: ");
    fprintf(file, receiver_account_no);
    fprintf(file, "\n");  
}

int main(int argc, char **argv) {
    char unimportant_data1[64];
    char unimportant_data2[64];
    char source_of_fund_secret_token[64];
    char unimportant_data4[64];
    char* receiver_account_no;
    
    fgets(unimportant_data1,
        64,
        fopen("/tmp/unimportant_data1.txt", "r"));
    fgets(unimportant_data2,
        64,
        fopen("/tmp/unimportant_data2.txt", "r"));
    fgets(source_of_fund_secret_token,
        64,
        fopen("/tmp/secret_token.txt", "r"));
    fgets(unimportant_data4,
        64,
        fopen("/tmp/unimportant_data4.txt", "r"));
    
    if (argc != 2) {
        fprintf(stdout, "Usage: ./transfer_fund <target_account_no>\n");
        fprintf(stdout, "Example: ./transfer_fund 7061037793\n");
    } else {
        receiver_account_no = argv[1];
        transfer_fund(stdout, source_of_fund_secret_token, receiver_account_no);
    }
        return 0;
}
	       
