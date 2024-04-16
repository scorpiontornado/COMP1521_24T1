#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <pthread.h>
#include <errno.h>


void *thread_run(void *data) {
    char *string = data;

    while (true) {
        printf("%s", string);
    }

    return NULL;
}

int main(void) {
    char *thread_message = "Hello\n";

    pthread_t thread;
    int ret = pthread_create(&thread, NULL, thread_run, thread_message);
    if (ret != 0) {
        errno = ret;
        perror("pthread_create");
        exit(EXIT_FAILURE);
    }

    while (true) {
        printf("there!\n");
    }

    // Stop the process exiting until the thread is done
    pthread_join(thread, NULL);
}