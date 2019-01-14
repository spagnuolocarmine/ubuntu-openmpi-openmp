#!/bin/sh

echo "apt-get update"
sudo apt-get update

echo "install vim"
sudo apt-get -y install vim 

echo "install htop"
sudo apt-get -y install htop 

echo "install build-essential"
sudo apt-get -y install build-essential

echo "install ssh"
sudo apt-get -y install openssh-client openssh-server 

echo "install OpenMPI"
wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.0.tar.gz
gunzip -c openmpi-4.0.0.tar.gz | tar xf -
cd openmpi-4.0.0
./configure --prefix=/usr/local
sudo make all install

echo "export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH" >> /home/pcpc/.bashrc
 
echo "clear"
cd ..
sudo rm -rf openmpi-4.0.0
rm openmpi-4.0.0.tar.gz

echo "Installation completed"

echo "create user pcpc"
sudo adduser pcpc
sudo usermod -aG sudo pcpc
echo "user pcpc created"


echo "configure ssh..."

#Change here using your private key
echo "-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAzqU6vBYSAJ5CAOWuOXu4820QNudtPQCtE50k5w51Ew88TZiW
UF9d9nlqLeB0Z2a0YD3AsMOxj1WQk0jT2jW0KD+N+X/His0XELOc+M1IXCyntP09
4RFYX4Pbsr//RGK8WnrETITW3vh3ETgdjU9IigrcqEuGYpDlC6315R4JO8UYP3yo
L52XgaXpWhdgDTlyZbNAfHSBli3xBf9wLXYnZO2pDcBnsIHOHmTc6ukIDxK8HiH/
7akP59b1VF4eAxReND1Hr4k2ShPPDXZE36jKLTVjG4bgr84LKF7kgsVrUQTKK6fC
ZRD2l10j2tBwroxyCk6ijWV4GLLuyo3LBR4/6QIDAQABAoIBAAbB0mTaF+abRi8/
U24fxJF5LIGPGbxX7FDq340KpPtlkSQ8bBXeuHTZzYYIg+XprtZCzq05CPJV6u9V
/09wWB7EzUCuU/kO8cUjCmv8UnRpJWa+rSpR5eDhr+ptasxyqhQPVaHm6hvKZiJT
AmxfflC9QC/koFVSxZqXKqY+UDD7Ft/TtPv8CMeBBPmrnwZBZ2rtKEWnk/KRPWD5
g4yWqQ6VOFcuOtJnd+3oVVvmF5hpgKGH0kZxqyr0ufI0HQHGyl5Oo5NSmaba51Vs
bM+zQWd8tAlmgVIDG7HP0HlA2+iMGAWr+6En/RpifQmxcQULp6tw6xdE0kT4kvrz
DV41DD0CgYEA6PpSc/OhwXK7PtXjuLXPK8qg8LiU5VlfMlUFg9nhqoOqTq4jvwt8
3cWF3kC1ZpzUGbhQwejZYS9MjUiygEDkrXrhA5V6cNn4SZ4kiqPp8xhxMMiVef+S
2Tcp6i4NWLjh9Pxaj/RE58G9Uo1njW8G/iQt3iWGAkRSKCkZMyaF+sMCgYEA4xDF
wwY5n+ERjWfRnVJYwSGDak6z0QVbPBjrDDWwuPBII/jPMINMGK3k75XW/bpEPmgn
CWzd0zNbWfU0faMmtq9xyFjfOs+6QmEh6nrPynMBp71Q4cndGL75NuNutKa1su2Z
QZhiL8Kt3PzWWJ4r5Il6LaBjKK8gJ5GQRQ27N+MCgYAROiFKraMyWLd7x/kUuWze
QhdwdVWdN+SQJjVIMJ49K4s2Ui4WfFT5WRey/XnsYoBUfoqKLBuW0haJA+0fCq1e
Ho3w4+av3Y48c1MkZUZxUUddYhebc8h6A1g4Frup6dHbeaWAq4FE2dCUABy+Go2b
0TULDh9An6iri45vd9PEXQKBgQCQvM1CroIm3oGgwG/GN4ppuWIaboaCk0Z/vWZ+
hu7aRBfIDj6LrvXfuWD4M2wymfwMR7mycVnI2bC+W+YUu93ej2EZE0VgKK+SxnWn
EJfJdZu1f6DB/DnaH0meakTUFHw3zOpm/KqBxTesaOJ85H4YFGX0FYt/kHoPnuL2
kXUofwKBgCWx8rjZCuqeLKQEQolTDYidWu/1HhiU/2pnKbGcz0zKIftf59XjHYsT
LlXgQm6/UVFJT8GNEQU/52/dxEQ4HxnEoAyLNB/AsiWndBPCG63pYePgQcYqzAdQ
eepII0jGJQ+nW4pKFl/wmKbKiyRXCE83qDYm1reXzTyUEj6ZQrC3
-----END RSA PRIVATE KEY-----
" >> id_rsa

#Change here using you public key
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOpTq8FhIAnkIA5a45e7jzbRA25209AK0TnSTnDnUTDzxNmJZQX132eWot4HRnZrRgPcCww7GPVZCTSNPaNbQoP435f8eKzRcQs5z4zUhcLKe0/T3hEVhfg9uyv/9EYrxaesRMhNbe+HcROB2NT0iKCtyoS4ZikOULrfXlHgk7xRg/fKgvnZeBpelaF2ANOXJls0B8dIGWLfEF/3Atdidk7akNwGewgc4eZNzq6QgPErweIf/tqQ/n1vVUXh4DFF40PUeviTZKE88NdkTfqMotNWMbhuCvzgsoXuSCxWtRBMorp8JlEPaXXSPa0HCujHIKTqKNZXgYsu7KjcsFHj/p pcpc@ubuntu
" >> id_rsa.pub 

#Change here using you public key
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOpTq8FhIAnkIA5a45e7jzbRA25209AK0TnSTnDnUTDzxNmJZQX132eWot4HRnZrRgPcCww7GPVZCTSNPaNbQoP435f8eKzRcQs5z4zUhcLKe0/T3hEVhfg9uyv/9EYrxaesRMhNbe+HcROB2NT0iKCtyoS4ZikOULrfXlHgk7xRg/fKgvnZeBpelaF2ANOXJls0B8dIGWLfEF/3Atdidk7akNwGewgc4eZNzq6QgPErweIf/tqQ/n1vVUXh4DFF40PUeviTZKE88NdkTfqMotNWMbhuCvzgsoXuSCxWtRBMorp8JlEPaXXSPa0HCujHIKTqKNZXgYsu7KjcsFHj/p pcpc@ubuntu
" >> authorized_keys 

chmod 600 id_rsa
chmod 640 id_rsa.pub

sudo mkdir  -p /home/pcpc/.ssh

sudo mv id_rsa /home/pcpc/.ssh
sudo mv id_rsa.pub /home/pcpc/.ssh
sudo mv authorized_keys /home/pcpc/.ssh

sudo chown pcpc:pcpc /home/pcpc/.ssh
sudo chown pcpc:pcpc /home/pcpc/.ssh/id_rsa
sudo chown pcpc:pcpc /home/pcpc/.ssh/id_rsa.pub
sudo chown pcpc:pcpc /home/pcpc/.ssh/authorized_keys
echo "ssh configurated"

echo "ldconfig on user pcpc"
sudo -u pcpc sudo ldconfig
