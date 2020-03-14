#!/bin/sh

ssh-keygen -t rsa -b 4096  -f "id_rsa" -q -P ""

echo "
#!/bin/sh

echo \"apt-get update\"
sudo apt-get update

echo \"install vim\"
sudo apt-get -y install vim

echo \"install htop\"
sudo apt-get -y install htop

echo \"install build-essential\"
sudo apt-get -y install build-essential

echo \"install ssh\"
sudo apt-get -y install openssh-client openssh-server

echo \"install OpenMPI\"
wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.0.tar.gz
gunzip -c openmpi-4.0.0.tar.gz | tar xf -
cd openmpi-4.0.0
./configure --prefix=/usr/local
sudo make all install

echo \"export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH\" >> /home/pcpc/.bashrc

echo \"clear\"
cd ..
sudo rm -rf openmpi-4.0.0
rm openmpi-4.0.0.tar.gz

echo \"Installation completed\"

echo \"create user pcpc\"
sudo useradd -s /bin/bash -d /home/pcpc/ -m -G sudo pcpc
echo -e \"root\nroot\" | sudo passwd pcpc
echo \"user pcpc created\"


echo \"configure ssh...\"

#Change here using your private key
echo \"`cat id_rsa`\"  > id_rsa

#Change here using you public key
echo \"`cat id_rsa.pub`\"  > id_rsa.pub

#Change here using you public key
echo \"`cat id_rsa.pub`\"  >> authorized_keys

echo \"Host *
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null\" >> config

chmod 600 id_rsa
chmod 640 id_rsa.pub

sudo mkdir  -p /home/pcpc/.ssh

sudo mv id_rsa /home/pcpc/.ssh
sudo mv id_rsa.pub /home/pcpc/.ssh
sudo mv config /home/pcpc/.ssh
sudo mv authorized_keys /home/pcpc/.ssh

sudo chown pcpc:pcpc /home/pcpc/.ssh
sudo chown pcpc:pcpc /home/pcpc/.ssh/config
sudo chown pcpc:pcpc /home/pcpc/.ssh/id_rsa
sudo chown pcpc:pcpc /home/pcpc/.ssh/id_rsa.pub
sudo chown pcpc:pcpc /home/pcpc/.ssh/authorized_keys
echo \"ssh configurated\"

echo \"ldconfig on user pcpc\"
echo -e \"root\n\" | sudo -u pcpc sudo -S ldconfig

" > install.sh
