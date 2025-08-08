#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

// Taken from https://www.codequoi.com/en/pipe-an-inter-process-communication-method

// Utility function for write
void writestr(int fd, const char *str)
{
	write(fd, str, strlen(str));
}

// Main
int main(void)
{
	int pipefd[2];  // Stores the pipe's fds:
	//- pipefd[0]: read only
	//- pipefd[1]: write only
	pid_t pid; // Stores fork's return value
	char buf; // Stores characters read by read

	//Create a pipe. Stop eveything on failure.
	if (pipe(pipefd) == -1)
	{
		perror("pipe");
		exit(EXIT_FAILURE);
	}

	// Create a child process
	pid = fork();
	if (pid == -1) // Failute, stop everything
	{
		perror("fork");
		exit(EXIT_FAILURE);
	}

	if (pid == 0) // Child process
	{
		// Close the unused write end
		close(pipefd[1]);
		writestr(STDOUT_FILENO, "Child: What is the secret in this pipe?\n");
		writestr(STDOUT_FILENO, "Child: \"");

		// Read characters from the pipe one by one
		while (read(pipefd[0], &buf, 1) > 0)
		{
			// Write the read character to standard output
			write(STDOUT_FILENO, &buf, 1);
		}

		writestr(STDOUT_FILENO, "\"\n");
		writestr(STDOUT_FILENO, "Child: Wow! I must go see my father.\n");

		//Close the read end of the pipe
		close(pipefd[0]);
		exit(EXIT_SUCCESS);
	}
	else // Parent process
	{
		// Close unused read end
		close(pipefd[0]);

		writestr(STDOUT_FILENO, "Parent: I'm writing a secret in this pipe...\n");

		// Write into the pipe
		writestr(pipefd[1], "\e[33mI am your father mwahahaha!\e[0m");

		// Close write end of the pipe (reader will see EOF)
		close(pipefd[1]);

		// Wait for child
		wait(NULL);

		writestr(STDOUT_FILENO, "Parent: Hello child!\n");
		exit(EXIT_SUCCESS);
	}
}
