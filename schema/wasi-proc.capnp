@0xb8adb3204142bb1e;
using import "wasi-common.capnp".Errno;

interface Proc {
   using Exitcode = UInt32; # Exit code generated by a process when exiting.

   # Signal condition.
   enum Signal {
    sigabrt @0; # Process abort signal. Action: Terminates the process.
    sigalrm @1; # Alarm clock. Action: Terminates the process
    sigbus @2; # Access to an undefined portion of a memory object. Action: Terminates the process.
    sigchld @3; # Child process terminated, stopped, or continued. Action: Ignored.
    sigcont @4; # Continue executing, if stopped. Action: Continues executing, if stopped.
    sigfpe @5; # Erroneous arithmetic operation. Action: Terminates the process.
    sighup @6; # Hangup. Action: Terminates the process.
    sigill @7; # Illegal instruction. Action: Terminates the process.
    sigint @8; # Terminate interrupt signal. Action: Terminates the process.
    sigkill @9; # Kill. Action: Terminates the process.
    sigpipe @10; # Write on a pipe with no one to read it. Action: Ignored.
    sigquit @11; # Terminal quit signal. Action: Terminates the process.
    sigsegv @12; # Invalid memory reference. Action: Terminates the process.
    sigstop @13; # Stop executing. Action: Stops executing.
    sigsys @14; # Bad system call. Action: Terminates the process.
    sigterm @15; # Termination signal. Action: Terminates the process.
    sigtrap @16; # Trace/breakpoint trap. Action: Terminates the process.
    sigtstp @17; # Terminal stop signal. Action: Stops executing.
    sigttin @18; # Background process attempting read. Action: Stops executing.
    sigttou @19; # Background process attempting write. Action: Stops executing.
    sigurg @20; # High bandwidth data is available at a socket. Action: Ignored.
    sigusr1 @21; # User-defined signal 1. Action: Terminates the process.
    sigusr2 @22; # User-defined signal 2. Action: Terminates the process.
    sigvtalrm @23; # Virtual timer expired. Action: Terminates the process.
    sigxcpu @24; # CPU time limit exceeded. Action: Terminates the process.
    sigxfsz @25; # File size limit exceeded. Action: Terminates the process
  }

  # Terminate the process normally. An exit code of 0 indicates successful termination of the program. The meanings of other values is dependent on the environment.
  # Note: This is similar to _Exit in POSIX.
  procExit @0 (
    rval :Exitcode # The exit code returned by the process.
  ) -> (
    error :Errno
  );

  # Send a signal to the process of the calling thread.
  # Note: This is similar to raise in POSIX.
  procRaise @1 (
    sig :Signal # The signal condition to trigger.
  ) -> (
    error :Errno  
  );

  # Temporarily yield execution of the calling thread.
  # Note: This is similar to sched_yield in POSIX.
  schedYield @2 () -> (
    error :Errno
  );
}