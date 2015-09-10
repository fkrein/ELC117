#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define INPUT_FILE "login.txt"
#define OUTPUT_FILE "leaked.txt"

typedef struct list{
	char* login;
	struct list* next;
	struct list* prev;
}leaked_list;

typedef struct{
	leaked_list* first;
	leaked_list* last;
}List;

List* read_file(void);
void filter_list(List* l);
void add_suffix(List* l);
void sort_list(List* l);
void print_to_file(List* l);
void list_destroy(List* l);

int main(void){

	List* l = read_file();
	if(l == NULL){
		printf("The program wasn't able to read the file");
		exit(1);
	}

	filter_list(l);
	add_suffix(l);
	sort_list(l);
	print_to_file(l);
	list_destroy(l);

	exit(0);
}

List* read_file(void){

	char c;
	int cont = 0;

	FILE* log_file = fopen(INPUT_FILE,"r");
	if(log_file == NULL) return NULL;

	List* l = (List*) malloc(sizeof(List));

	leaked_list* elem = (leaked_list*) malloc(sizeof(leaked_list));
	elem->login = (char*) malloc(sizeof(char));
	elem->next = NULL;
	elem->prev = NULL;
	l->first = elem;
	l->last = elem;
	
	while((c = fgetc(log_file)) != EOF){
		if(c == '\n'){
			l->last->login[cont] = '\0';
			elem = (leaked_list*) malloc(sizeof(leaked_list));
			elem->login = (char*) malloc(sizeof(char));
			elem->prev = l->last;
			elem->next = NULL;
			l->last->next = elem;
			l->last = elem;
			cont = 0;
		}else{
			l->last->login[cont] = c;
			cont++;
			l->last->login = (char*) realloc(l->last->login, cont+1);
		}
	}

	leaked_list* cpy = l->last;
	l->last = l->last->prev;
	l->last->next = NULL;
	
	free(cpy->login);
	free(cpy);

	fclose(log_file);

	return l;
}

void filter_list(List* l){
	leaked_list* cpy = l->first;
	while(cpy != NULL){
		if(strlen(cpy->login) > 8){
			if(cpy->prev == NULL && cpy->next == NULL){
				l->first = NULL;
				l->last = NULL;
			}else if(cpy->prev == NULL){
				cpy->next->prev = NULL;
				l->first = cpy->next;
			}else if(cpy->next == NULL){
				cpy->prev->next = NULL;
				l->last = cpy->prev;
			}else{
				cpy->prev->next = cpy->next;
				cpy->next->prev = cpy->prev;
			}
			leaked_list* cpy2 = cpy->next;
			free(cpy->login);
			free(cpy);
			cpy = cpy2;
			continue;
		}
		cpy = cpy->next;
	}
}

void add_suffix(List* l){
	leaked_list* cpy = l->first;
	while(cpy != NULL){
		cpy->login = (char*) realloc(cpy->login, strlen(cpy->login) + 14);
		strcat(cpy->login, "@mycompany.com");
		cpy = cpy->next;
	}
}

void sort_list(List* l){

	leaked_list* cpy1 = l->first;
	leaked_list* cpy2;
	char* aux;
	while(cpy1 != NULL){
		cpy2 = cpy1->next;
		while(cpy2 != NULL){
			if(strcmp(cpy1->login, cpy2->login) > 0){
				aux = cpy1->login;
				cpy1->login = cpy2->login;
				cpy2->login = aux;
			}
			cpy2 = cpy2->next;
		}
		cpy1 = cpy1->next;
	}
}

void print_to_file(List* l){

	leaked_list* cpy = l->first;
	FILE* log_file = fopen(OUTPUT_FILE,"w");
	while(cpy != NULL){
		fprintf(log_file, "%s\n", cpy->login);
		cpy = cpy->next;
	}
	fclose(log_file);
}

void list_destroy(List* l){

	leaked_list* cpy = l->first;
	while(cpy != NULL){
		l->first = l->first->next;
		free(cpy->login);
		free(cpy);
		cpy = l->first;
	}
	free(l);
}