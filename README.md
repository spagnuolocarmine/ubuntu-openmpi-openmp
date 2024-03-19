# Ubuntu with OpenMPI and OpenMP

This project provides tutorials and scripts to install OpenMPI and OpenMP on Ubuntu Linux machines.

## Prerequisites

 - Ubuntu Linux 18.04 LTS Server Edition 
 - SSH Key

## SSH Keys

- Generate your SSH key specifying the proper username to use in the `ssh` and `scp` commands: ```ssh-keygen -t rsa -C <username>```.
- Access the value of the SSH public key using ```cat <ssh-key-file>```.
- Add it to the machines you need to access.

## Cluster Scenario

- 1 MASTER Node, where you must generate the SSH key and update the script.
- N WORKERs, here you have to run the script using the keys generated on the master node.
- Install `git` on machines using `sudo apt update && sudo apt install git`.

## Installing

1. Copy on the MASTER node, from your local machine, the SSH key using the External IP: 
```scp -i "<ssh-key-file>" <ssh-key-file> username@<instance-External-IP>:```
2. Login on the MASTER node using the External IP:
```ssh -i <ssh-key-file> username@<instance-External-IP>```
3. Clone the repository:
```git clone https://github.com/spagnuolocarmine/ubuntu-openmpi-openmp.git```
4. Generates the installing script for your cluster:
```source generateInstall.sh```, results in a ```install.sh``` script with new ssh-keys for the cluster.
5. Run `chmod +x install.sh` and then run the script ```install.sh``` on the MASTER from your user.
6. For each WORKER instance, run the install script from the MASTER node (your user):
```ssh -i <ssh-key-file> username@<instance-External-IP> 'bash -s' < install.sh```
E.G. ```ssh -i .ssh/id_rsa myusername@12.345.67.890 'bash -s' < install.sh``` 

_The password for the pcpc user is **root**_

### Test 

1. On the MASTER node, login to `pcpc` user
```sudo login pcpc```, password: root
2. Local login 
```ssh localhost```
3. Remote login on a worker node
```ssh IP```

The program will create a new user, `pcpc`, and exchange the given ssh keys.

### Environment

- user: pcpc
- vim
- htop
- OpenMPI 4.0
- OpenMP included in the GNU GCC (last version)

## Test the environment

You can test your local environment using the program `hello-mpi.c`.

1. Compile the program: ```mpicc hello-mpi.c -o hello```
2. Run the porgram: ```mpirun -np 2 ./hello```
3. Run with more MPI processes on single core ```mpirun -np 3 --oversubscribe a.out```

You can run directly on a homogeneous cluster machine that has been built using the same install script. You can run: ```mpirun -np 2 --hostfile hfile ./hello```.

An example of a host file is:
```
# This is an example host file.  Comments begin with #
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
- Giuseppe D'Ambrosio (University of Salerno)
- Tiziano Citro (University of Salerno)
