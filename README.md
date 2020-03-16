# Ubuntu with OpenMPI and OpenMP

This project provides scripts and tutorial to install OpenMPI and OpenMP on a Ubuntu Linux.

## Prerequisites
 - Ubuntu Linux 18.04 LTS Server Edition - Amzon AMI ami-0f65671a86f061fcd
 - SSH Key

## Cluster Scenario

- 1 Master Node, here you have to generate the ssh-key and update the script.
- N Slaves, here you have to run the script using the keys generated on the master node.


## Install

1. Run the script on your remote (MASTER) machine ```bash generateInstall.sh```. The script generates a ```install.sh``` with new ssh-keys.
2. Set the passoword for the user pcpc: ```sudo passwd pcpc``
3. Copy on the MASTER node the pem key: ``scp -i "k.pem" k.pem ubuntu@ec2-34-239-142-46.compute-1.amazonaws.com:``
3. For each SLAVE instance run the following command on you machine 
```ssh -i <path-to-pem-file>  <connection-string-for-the-EC2-instace>  'bash -s' < install.sh```.

The program will create a new user pcpc and exchanges the given ssh keys.

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
3. Run with more MPI processes on single core ```mpirun -np 3 --oversubscribe a.out```

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
