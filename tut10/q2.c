#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <spawn.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>

// extern means the variable is defined somewhere else.
// In this case, the variable is defined by the system environment.
extern char **environ;

// Spawns a process and waits for it to die.
// Input is the argv array of the process function.
void spawn_and_wait(char **args) {
    // todo: run posix_spawn
    pid_t pid;
    int spawn_status = posix_spawn(&pid, args[0], NULL, NULL, args, environ);    
    
    if (spawn_status != 0) {
        errno = spawn_status;
        perror("posix_spawn");
        exit(EXIT_FAILURE);
    }

    int spawn_exit_status;

    if (waitpid(pid, &spawn_exit_status, 0) == -1) {
        perror("waitpid");
        exit(EXIT_FAILURE);
    }
}

int main(int argc, char *argv[]) {
    // todo: run the /bin/date program with the argument "+%d-%m-%Y"
    char *date_argv[] = {"/bin/date", "+%d-%m-%Y", NULL};
    spawn_and_wait(date_argv);

    // todo: run the /bin/date program with argument "+%T"
    char *time_argv[] = {"/bin/date", "+%T", NULL};
    spawn_and_wait(time_argv); 
    
    // todo: run /usr/bin/whoami

    // todo: run the /bin/hostname program with argument "-f"
    // The -f flag is short for 'full': print full output, not shortened.

    // todo: run the /usr/bin/realpath program with argument "."
}
