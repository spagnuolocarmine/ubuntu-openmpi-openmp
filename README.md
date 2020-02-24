# Ubuntu with OpenMPI and OpenMP

This project provides scripts and tutorial to install OpenMPI and OpenMP on a Ubuntu Linux.

## Prerequisites
 - Ubuntu Linux 18.04 LTS Server Edition - Amzon AMI ami-0f65671a86f061fcd
 - SSH Key

## Cluster Scenario

- 1 Master Node, here you have to generate the ssh-key and update the script.
- N Slaves, here you have to run the script using the keys generated on the master node.

### How to generate your SSH keys

Execute che command ```ssh-keygen```.

Note. By using this command without parameters the key is stored in the folder .ssh, in the file id_rsa e id_rsa.pub.

## Install

Change the file install.sh with the generated key.

Run the script on you machine ```sudo bash install.sh```.

The program will create a new user pcpc and exchanges the given ssh keys.

**After the installation manually connect on each node to share youy SSH id.**


### Environment
- user: pcpc
- vim
- htop
- OpenMPI 4.0
- OpenMP included in the GNU GCC (last version)

## Test the environment

You can test your local environment using the program test.c.

1. Compile the program: ```mpicc hello-mpi.c -o hello```
2. Run the porgram: ```mpirun -np 2 ./hello```

You can run directly on an homogeneous cluster machine that has been built using the same install script. You can run: ```mpirun -np 2 --hostfile hfile ./hello```.

An example host-file is:
```
# This is an example hostfile.  Comments begin with #
#
# The following node is a single processor machine:
foo.example.com
 
# The following node is a dual-processor machine:
bar.example.com slots=2
 
# The following node is a quad-processor machine, and we absolutely
# want to disallow over-subscribing it:
yow.example.com slots=4 max-slots=4
```

# Authors and Contributors

- Matteo D'Auria (University of Salerno)
- Carmine Spagnuolo (University of Salerno)
