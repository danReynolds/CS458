a1 things to look at:

Module 2,
Smashing the Stack for Fun and Profit http://insecure.org/stf/smashstack.html
Exploiting Format String Vulnerabilities http://julianor.tripod.com/bc/formatstring-1.2.pdf sections 1-3
man pages for execve, pipe, popen, getenv, setenv, passwd, shadow, symlink, expect

# Potential Exploits:

1) they use getuid, which returns the password of the current user. In retrospect, not helpful, thought might give root pass.

2) get_submit_dir strcpy's without a length check, using the user's name and the submit directory.

3) get_dst_name also uses unbounded strcpy to put the source filename and destination directory, submit/username together.

4) get_log_filename does the same sort of thing, fetching the userid, then the password info for him so that you can make /home/username/logfilename

5) logfilename is made using realpath, which if specified as NULL for 2nd buffer param, returns a buffer of up to PATH_MAX bytes to hold the pathname, returning a pointer to this buffer.

If there is an error in realpath, then the contents of the returned buffer are undefined. There will be an error if a component doesn't exist, something goes wrong.

6) `check_for_viruses` keeps reading in characters from the src file looking for /bin/sh, but only 1024, hmm...

7) If you overwrote the message in log_message to something?

8) show confirmation runs /bin/ls, if we could change this string to /bin/bash?

9) They sprintf this, without formatting. Also, they use a buffer size of 640, way more than enough for the string "Submission program version 0.1 (%s)\n"

# Facts:

`snprintf(s, n, format)` = composes a string with the same sized text that would be printed if format was used on printf, then storing it as a C string,
in the buffer s. n is the max number of bytes allowed in the generated buffer.

`link/unlink` are doing hard link increases and decreases.

`stat` returns data about an inode, then the mode_t can be checked off of it to determine if the file is a directory with S_ISDIR.

`getuid` returns the real user ID of the calling process.

`getgid` returns the greal group ID of the calling process.

`getpwuid` returns a pointer to a structure containing a bunch of password fields, including USER PASSWORD, username, home directory, etc.

`realpath` expands all symbolic links and resolves reference to . or ..

`creat S_IWUSR | S_IRUSR` create a file with read write permission.

`fchown` change ownership of a file, to the specified user and group.

`fputs` puts a string of any length into a file.

`getopt_long` getopt parses comand-line arguments, like -s, -v.

`va_arg` for varying number of arguments, calling va_arg gets the next argument and makes it so the one after that will be retrieved on the next successive call to va_arg.

Maybe that can be exploited?

## Suggested Readings

`execve` = filename, then args array to pass to file that is run.

`popen` = opens a process by creating a pipe, forking and invoking the shell. So you can use it to run ls or something in a shell opened.

`getenv` = get the value of an environment variable.

`setenv` = set the value of an env variable.

`passwd` = /etc/passwd is a text file that describes user login accounts for the system.

`shadow` = shadowed password file, contains the password info for the system's accounts. Root access only, has encrypted password visible.

`expect` = talks to other interactive programs according to a script. It can cause your computer to start a game, and then restart until certain conditions are met such that you'd want to play. It can run fsck, say yes or no to things as needed, then hand over control.

Can carry environment variables, current directory, across su, etc.
