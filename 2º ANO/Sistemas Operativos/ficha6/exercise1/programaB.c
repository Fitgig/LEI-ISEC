#include <stdio.h>
#include <pthread.h>
#include <time.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

//pthread_mutex_t lock;

struct structThread{
	char letra;
	int flagCancel;
	pthread_mutex_t *lockThread;
};

void *handler_thread(void *argThread){
	struct structThread *s = (struct structThread *) argThread;
	srand(time(NULL));

	while(!s->flagCancel){
		int time = 1 + rand() % 5;
		for(int i = 0; i < time; i++){
			printf(" . ");
			sleep(1);
		}

		pthread_mutex_lock(s->lockThread);

		for(int i = 0; i < 3; i++){
			printf(" %c ", s->letra);
			sleep(1);
		}

		pthread_mutex_unlock(s->lockThread);
	}
}

int main(int argc, char **argv){
	setbuf(stdout, NULL);

	char palavra[10];

	pthread_t threads[2];
	pthread_mutex_t lock;
	struct structThread sA;
	struct structThread sB;

	sA.letra = 'A';
	sB.letra = 'B';
	sA.flagCancel = 0;
	sB.flagCancel = 0;
	sA.lockThread = &lock;
	sB.lockThread = &lock;

	printf(" >> ");

	pthread_mutex_init(&lock, NULL);

	pthread_create(&threads[0], NULL, &handler_thread, &sA);
	pthread_create(&threads[1], NULL, &handler_thread, &sB);

	do{
		scanf(" %s", palavra);
	} while(strcmp(palavra, "sair") != 0);

	sA.flagCancel = 1;
	pthread_join(threads[0], NULL);

	sB.flagCancel = 1;
	pthread_join(threads[1], NULL);

	return 0;
}
